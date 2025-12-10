namespace fredborg.webshop;

page 50106 "DEF Webshop Line API"
{
    PageType = API;
    APIPublisher = 'myCompany';
    APIGroup = 'webshop';
    APIVersion = 'v1.0';
    EntityName = 'webshopOrderLine';
    EntitySetName = 'webshopOrderLines';
    SourceTable = "DEF Webshop Line Staging TDY";
    DelayedInsert = true;
    ODataKeyFields = "Webshop Order No.", "Line No.";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(webshopOrderNo; Rec."Webshop Order No.")
                {
                    Caption = 'Webshop Order No.';
                }
                field(lineNo; Rec."Line No.")
                {
                    Caption = 'Line No.';
                }
                field(webshopProductID; Rec."Webshop Product ID")
                {
                    Caption = 'Webshop Product ID';
                }
                field(productSKU; Rec."Product SKU")
                {
                    Caption = 'Product SKU';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(quantity; Rec.Quantity)
                {
                    Caption = 'Quantity';
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';
                }
                field(lineAmount; Rec."Line Amount")
                {
                    Caption = 'Line Amount';
                }
                field(discountPercent; Rec."Discount Percent")
                {
                    Caption = 'Discount Percent';
                }
                field(discountAmount; Rec."Discount Amount")
                {
                    Caption = 'Discount Amount';
                }
                field(taxPercent; Rec."Tax Percent")
                {
                    Caption = 'Tax Percent';
                }
                field(taxAmount; Rec."Tax Amount")
                {
                    Caption = 'Tax Amount';
                }
            }
        }
    }
}