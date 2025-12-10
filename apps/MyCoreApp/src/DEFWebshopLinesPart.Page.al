namespace fredborg.webshop;

page 50104 "DEF Webshop Lines Part"
{
    PageType = ListPart;
    SourceTable = "DEF Webshop Line Staging TDY";
    Caption = 'Lines';
    Editable = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Line No. which is used for identifying the line within the order.';
                }
                field("Webshop Product ID"; Rec."Webshop Product ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Webshop Product ID which is used for identifying the product in the webshop system.';
                }
                field("Product SKU"; Rec."Product SKU")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Product SKU which is used for identifying the product in the inventory system.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Description which is used for describing the product.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Quantity which is used for the number of units ordered.';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Unit Price which is used for the price per unit.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Line Amount which is used for the total amount for this line.';
                }
                field("Discount Percent"; Rec."Discount Percent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Discount Percent which is used for the discount percentage applied to this line.';
                    Visible = false;
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Discount Amount which is used for the discount amount applied to this line.';
                }
                field("Tax Percent"; Rec."Tax Percent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Tax Percent which is used for the tax percentage applied to this line.';
                    Visible = false;
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Tax Amount which is used for the tax amount applied to this line.';
                }
            }
        }
    }
}