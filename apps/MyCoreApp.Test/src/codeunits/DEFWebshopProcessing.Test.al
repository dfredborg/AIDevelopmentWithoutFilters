namespace fredborg.webshop.test;

using fredborg.webshop;
using Microsoft.Sales.Document;
using Microsoft.Sales.Customer;
using Microsoft.Inventory.Item;

codeunit 50150 "DEF Webshop Processing Test"
{
    Subtype = Test;

    var
        Assert: Codeunit "Library Assert";
        LibrarySales: Codeunit "Library - Sales";
        LibraryInventory: Codeunit "Library - Inventory";

    [Test]
    procedure Process_Success_CreatesSalesOrder()
    var
        WebshopHeader: Record "DEF Webshop Header Staging TDY";
        WebshopLine: Record "DEF Webshop Line Staging TDY";
        Customer: Record Customer;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        WebshopProcessing: Codeunit "DEF Webshop Processing";
    begin
        // [GIVEN] A valid customer and item exist
        CreateCustomer(Customer, 'test@customer.com');
        CreateItem(Item, 'ITEM001');

        // [GIVEN] A staging header with valid data
        CreateWebshopHeader(WebshopHeader, 'WEB-001', 'test@customer.com', '2024-12-16');

        // [GIVEN] A staging line with valid data
        CreateWebshopLine(WebshopLine, 'WEB-001', 10000, 'ITEM001', '5', '100');

        // [WHEN] Processing the order
        WebshopProcessing.Process(WebshopHeader);

        // [THEN] The staging header status should be Completed
        Assert.AreEqual(WebshopHeader.Status::Completed, WebshopHeader.Status, 'Status should be Completed');
        Assert.AreEqual('', WebshopHeader."Error Message", 'Error message should be empty');

        // [THEN] A sales order should be created
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("External Document No.", 'WEB-001');
        Assert.IsTrue(SalesHeader.FindFirst(), 'Sales Header should exist');
        Assert.AreEqual(Customer."No.", SalesHeader."Sell-to Customer No.", 'Customer No. should match');

        // [THEN] A sales line should be created with correct data
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        Assert.IsTrue(SalesLine.FindFirst(), 'Sales Line should exist');
        Assert.AreEqual(Item."No.", SalesLine."No.", 'Item No. should match');
        Assert.AreEqual(5, SalesLine.Quantity, 'Quantity should be 5');
        Assert.AreEqual(100, SalesLine."Unit Price", 'Unit Price should be 100');

        // Cleanup
        CleanupSalesOrder(SalesHeader);
        CleanupTestData(WebshopHeader, Customer, Item);
    end;

    [Test]
    procedure Process_UnknownCustomer_SetsError()
    var
        WebshopHeader: Record "DEF Webshop Header Staging TDY";
        WebshopLine: Record "DEF Webshop Line Staging TDY";
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        WebshopProcessing: Codeunit "DEF Webshop Processing";
    begin
        // [GIVEN] An item exists but customer does not
        CreateItem(Item, 'ITEM002');

        // [GIVEN] A staging header with non-existent customer email
        CreateWebshopHeader(WebshopHeader, 'WEB-002', 'nonexistent@customer.com', '2024-12-16');

        // [GIVEN] A staging line with valid data
        CreateWebshopLine(WebshopLine, 'WEB-002', 10000, 'ITEM002', '3', '50');

        // [WHEN] Processing the order
        WebshopProcessing.Process(WebshopHeader);

        // [THEN] The staging header status should be Error
        Assert.AreEqual(WebshopHeader.Status::Error, WebshopHeader.Status, 'Status should be Error');
        Assert.IsTrue(StrPos(WebshopHeader."Error Message", 'Customer') > 0, 'Error message should contain "Customer"');

        // [THEN] No sales order should be created
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("External Document No.", 'WEB-002');
        Assert.IsFalse(SalesHeader.FindFirst(), 'Sales Header should not exist');

        // Cleanup
        CleanupTestData(WebshopHeader, Item);
    end;

    [Test]
    procedure Process_UnknownItem_SetsError()
    var
        WebshopHeader: Record "DEF Webshop Header Staging TDY";
        WebshopLine: Record "DEF Webshop Line Staging TDY";
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        WebshopProcessing: Codeunit "DEF Webshop Processing";
    begin
        // [GIVEN] A valid customer exists but item does not
        CreateCustomer(Customer, 'test2@customer.com');

        // [GIVEN] A staging header with valid data
        CreateWebshopHeader(WebshopHeader, 'WEB-003', 'test2@customer.com', '2024-12-16');

        // [GIVEN] A staging line with non-existent item SKU
        CreateWebshopLine(WebshopLine, 'WEB-003', 10000, 'NONEXISTENT', '2', '75');

        // [WHEN] Processing the order
        WebshopProcessing.Process(WebshopHeader);

        // [THEN] The staging header status should be Error
        Assert.AreEqual(WebshopHeader.Status::Error, WebshopHeader.Status, 'Status should be Error');
        Assert.IsTrue(StrPos(WebshopHeader."Error Message", 'Item') > 0, 'Error message should contain "Item"');

        // [THEN] No sales order should be created (transaction rolled back)
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("External Document No.", 'WEB-003');
        Assert.IsFalse(SalesHeader.FindFirst(), 'Sales Header should not exist (rolled back)');

        // Cleanup
        CleanupTestData(WebshopHeader, Customer);
    end;

    [Test]
    procedure Process_InvalidData_SetsError()
    var
        WebshopHeader: Record "DEF Webshop Header Staging TDY";
        WebshopLine: Record "DEF Webshop Line Staging TDY";
        Customer: Record Customer;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        WebshopProcessing: Codeunit "DEF Webshop Processing";
    begin
        // [GIVEN] A valid customer and item exist
        CreateCustomer(Customer, 'test3@customer.com');
        CreateItem(Item, 'ITEM003');

        // [GIVEN] A staging header with valid data
        CreateWebshopHeader(WebshopHeader, 'WEB-004', 'test3@customer.com', '2024-12-16');

        // [GIVEN] A staging line with invalid quantity (not a number)
        CreateWebshopLine(WebshopLine, 'WEB-004', 10000, 'ITEM003', 'ABC', '60');

        // [WHEN] Processing the order
        WebshopProcessing.Process(WebshopHeader);

        // [THEN] The staging header status should be Error
        Assert.AreEqual(WebshopHeader.Status::Error, WebshopHeader.Status, 'Status should be Error');
        Assert.IsTrue(StrPos(WebshopHeader."Error Message", 'convert') > 0, 'Error message should contain conversion error');

        // [THEN] No sales order should be created
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetRange("External Document No.", 'WEB-004');
        Assert.IsFalse(SalesHeader.FindFirst(), 'Sales Header should not exist');

        // Cleanup
        CleanupTestData(WebshopHeader, Customer, Item);
    end;

    // Helper procedures for test data creation

    local procedure CreateCustomer(var Customer: Record Customer; Email: Text[80])
    begin
        Customer.Init();
        Customer."No." := CopyStr('CUST-' + Format(CreateGuid()), 1, MaxStrLen(Customer."No."));
        Customer.Insert(true);
        Customer.Validate(Name, 'Test Customer ' + Customer."No.");
        Customer.Validate("E-Mail", Email);
        Customer.Modify(true);
    end;

    local procedure CreateItem(var Item: Record Item; ItemNo: Code[20])
    begin
        Item.Init();
        Item."No." := ItemNo;
        Item.Insert(true);
        Item.Validate(Description, 'Test Item ' + ItemNo);
        Item.Validate("Unit Price", 100);
        Item.Validate(Type, Item.Type::Inventory);
        Item.Modify(true);
    end;

    local procedure CreateWebshopHeader(var WebshopHeader: Record "DEF Webshop Header Staging TDY"; OrderNo: Text[100]; CustomerEmail: Text[1024]; OrderDate: Text[1024])
    begin
        WebshopHeader.Init();
        WebshopHeader."Webshop Order No." := OrderNo;
        WebshopHeader."Customer Email" := CustomerEmail;
        WebshopHeader."Order Date" := OrderDate;
        WebshopHeader.Status := WebshopHeader.Status::Pending;
        WebshopHeader.Insert(true);
    end;

    local procedure CreateWebshopLine(var WebshopLine: Record "DEF Webshop Line Staging TDY"; OrderNo: Text[100]; LineNo: Integer; SKU: Text[1024]; Qty: Text[1024]; UnitPrice: Text[1024])
    begin
        WebshopLine.Init();
        WebshopLine."Webshop Order No." := OrderNo;
        WebshopLine."Line No." := LineNo;
        WebshopLine."Product SKU" := SKU;
        WebshopLine.Quantity := Qty;
        WebshopLine."Unit Price" := UnitPrice;
        WebshopLine.Insert(true);
    end;

    local procedure CleanupSalesOrder(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
    begin
        if SalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.") then begin
            SalesLine.SetRange("Document Type", SalesHeader."Document Type");
            SalesLine.SetRange("Document No.", SalesHeader."No.");
            SalesLine.DeleteAll(true);
            SalesHeader.Delete(true);
        end;
    end;

    local procedure CleanupTestData(var WebshopHeader: Record "DEF Webshop Header Staging TDY"; var Customer: Record Customer)
    var
        WebshopLine: Record "DEF Webshop Line Staging TDY";
    begin
        if WebshopHeader.Get(WebshopHeader."Webshop Order No.") then begin
            WebshopLine.SetRange("Webshop Order No.", WebshopHeader."Webshop Order No.");
            WebshopLine.DeleteAll(true);
            WebshopHeader.Delete(true);
        end;

        if Customer.Get(Customer."No.") then
            Customer.Delete(true);
    end;

    local procedure CleanupTestData(var WebshopHeader: Record "DEF Webshop Header Staging TDY"; var Customer: Record Customer; var Item: Record Item)
    begin
        CleanupTestData(WebshopHeader, Customer);

        if Item.Get(Item."No.") then
            Item.Delete(true);
    end;

    local procedure CleanupTestData(var WebshopHeader: Record "DEF Webshop Header Staging TDY"; var Item: Record Item)
    var
        WebshopLine: Record "DEF Webshop Line Staging TDY";
    begin
        if WebshopHeader.Get(WebshopHeader."Webshop Order No.") then begin
            WebshopLine.SetRange("Webshop Order No.", WebshopHeader."Webshop Order No.");
            WebshopLine.DeleteAll(true);
            WebshopHeader.Delete(true);
        end;

        if Item.Get(Item."No.") then
            Item.Delete(true);
    end;
}