namespace fredborg.webshop;

using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;

codeunit 50107 "DEF Webshop Processing TDY"
{
    TableNo = "DEF Webshop Header Staging TDY";

    trigger OnRun()
    begin
        CreateSalesOrder(Rec);
    end;

    /// <summary>
    /// Public procedure to process a webshop order with transaction isolation and error handling.
    /// </summary>
    /// <param name="WebshopHeader">The webshop header staging record to process.</param>
    procedure Process(var WebshopHeader: Record "DEF Webshop Header Staging TDY")
    var
        WebshopProcessing: Codeunit "DEF Webshop Processing TDY";
    begin
        // Use Codeunit.Run to isolate the transaction
        if WebshopProcessing.Run(WebshopHeader) then begin
            WebshopHeader.Status := WebshopHeader.Status::Completed;
            WebshopHeader."Error Message" := '';
        end else begin
            WebshopHeader.Status := WebshopHeader.Status::Error;
            WebshopHeader."Error Message" := CopyStr(GetLastErrorText(), 1, MaxStrLen(WebshopHeader."Error Message"));
        end;
        WebshopHeader.Modify();
    end;

    local procedure CreateSalesOrder(WebshopHeader: Record "DEF Webshop Header Staging TDY")
    var
        SalesHeader: Record "Sales Header";
        WebshopLine: Record "DEF Webshop Line Staging TDY";
        CustomerNo: Code[20];
    begin
        // Step 1: Identify Customer
        CustomerNo := GetCustomerNo(WebshopHeader."Customer Email");
        if CustomerNo = '' then
            Error('Customer with email %1 not found.', WebshopHeader."Customer Email");

        // Step 2: Create Sales Header
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Order;
        SalesHeader."No." := '';
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", CustomerNo);
        SalesHeader.Validate("External Document No.", CopyStr(WebshopHeader."Webshop Order No.", 1, MaxStrLen(SalesHeader."External Document No.")));
        SalesHeader.Validate("Order Date", ParseDate(WebshopHeader."Order Date"));
        SalesHeader.Modify(true);

        // Step 3: Process Lines
        WebshopLine.SetRange("Webshop Order No.", WebshopHeader."Webshop Order No.");
        if WebshopLine.FindSet() then
            repeat
                CreateSalesLine(SalesHeader, WebshopLine);
            until WebshopLine.Next() = 0;
    end;

    local procedure CreateSalesLine(SalesHeader: Record "Sales Header"; StagingLine: Record "DEF Webshop Line Staging TDY")
    var
        SalesLine: Record "Sales Line";
        ItemNo: Code[20];
    begin
        // Step 4: Identify Item
        ItemNo := GetItemNo(StagingLine."Product SKU");
        if ItemNo = '' then
            Error('Item with SKU %1 not found.', StagingLine."Product SKU");

        // Step 5: Create Sales Line
        SalesLine.Init();
        SalesLine."Document Type" := SalesHeader."Document Type";
        SalesLine."Document No." := SalesHeader."No.";
        SalesLine."Line No." := StagingLine."Line No.";
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", ItemNo);
        SalesLine.Validate(Quantity, ParseDecimal(StagingLine.Quantity));
        SalesLine.Validate("Unit Price", ParseDecimal(StagingLine."Unit Price"));
        SalesLine.Modify(true);
    end;

    local procedure GetCustomerNo(Email: Text): Code[20]
    var
        Customer: Record Customer;
    begin
        Customer.SetRange("E-Mail", CopyStr(Email, 1, MaxStrLen(Customer."E-Mail")));
        if Customer.FindFirst() then
            exit(Customer."No.");
        exit('');
    end;

    local procedure GetItemNo(SKU: Text): Code[20]
    var
        Item: Record Item;
    begin
        if Item.Get(CopyStr(SKU, 1, MaxStrLen(Item."No."))) then
            exit(Item."No.");
        exit('');
    end;

    local procedure ParseDecimal(Value: Text): Decimal
    var
        Result: Decimal;
    begin
        if not Evaluate(Result, Value) then
            Error('Unable to convert value "%1" to decimal.', Value);
        exit(Result);
    end;

    local procedure ParseDate(Value: Text): Date
    var
        Result: Date;
    begin
        if not Evaluate(Result, Value) then
            Error('Unable to convert value "%1" to date.', Value);
        exit(Result);
    end;
}