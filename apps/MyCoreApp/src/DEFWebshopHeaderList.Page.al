namespace fredborg.webshop;

page 50102 "DEF Webshop Header List"
{
    PageType = List;
    SourceTable = "DEF Webshop Header Staging TDY";
    Caption = 'Webshop Orders';
    CardPageID = "DEF Webshop Header Card";
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Orders)
            {
                field("Webshop Order No."; Rec."Webshop Order No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Webshop Order No. which is used for identifying the order in the webshop system.';
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Order Date which is used for the date the order was placed.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer Name which is used for identifying the customer who placed the order.';
                }
                field("Customer Email"; Rec."Customer Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer Email which is used for contacting the customer.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Status which is used for tracking the processing state of the order.';
                }
                field("Order Total"; Rec."Order Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Order Total which is used for the total value of the order including tax and shipping.';
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Currency which is used for the currency of the order.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Error Message which is used for displaying any errors that occurred during processing.';
                    Style = Unfavorable;
                    StyleExpr = Rec.Status = Rec.Status::Error;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ProcessOrder)
            {
                ApplicationArea = All;
                Caption = 'Process Order';
                ToolTip = 'Validates and converts the staging record to a Sales Order.';
                Image = Process;

                trigger OnAction()
                var
                    WebshopProcessing: Codeunit "DEF Webshop Processing TDY";
                begin
                    WebshopProcessing.Process(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }
}