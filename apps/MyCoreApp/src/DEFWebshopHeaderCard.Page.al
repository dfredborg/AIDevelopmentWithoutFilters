namespace fredborg.webshop;

page 50103 "DEF Webshop Header Card"
{
    PageType = Card;
    SourceTable = "DEF Webshop Header Staging TDY";
    Caption = 'Webshop Order Card';
    Editable = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Status which is used for tracking the processing state of the order.';
                }
                field("Error Message"; Rec."Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Error Message which is used for displaying any errors that occurred during processing.';
                    MultiLine = true;
                    Style = Unfavorable;
                    StyleExpr = Rec.Status = Rec.Status::Error;
                }
            }

            group(Customer)
            {
                Caption = 'Customer';

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
                field("Customer Phone"; Rec."Customer Phone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer Phone which is used for contacting the customer by phone.';
                }
            }

            group(ShippingBilling)
            {
                Caption = 'Shipping & Billing';

                group(Shipping)
                {
                    Caption = 'Shipping Address';

                    field("Shipping Name"; Rec."Shipping Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Shipping Name which is used for the recipient name.';
                    }
                    field("Shipping Address"; Rec."Shipping Address")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Shipping Address which is used for the delivery street address.';
                    }
                    field("Shipping Address 2"; Rec."Shipping Address 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Shipping Address 2 which is used for additional address information.';
                    }
                    field("Shipping City"; Rec."Shipping City")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Shipping City which is used for the delivery city.';
                    }
                    field("Shipping Post Code"; Rec."Shipping Post Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Shipping Post Code which is used for the delivery postal code.';
                    }
                    field("Shipping Country Code"; Rec."Shipping Country Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Shipping Country Code which is used for the delivery country.';
                    }
                }

                group(Billing)
                {
                    Caption = 'Billing Address';

                    field("Billing Name"; Rec."Billing Name")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Billing Name which is used for the invoice recipient name.';
                    }
                    field("Billing Address"; Rec."Billing Address")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Billing Address which is used for the invoice street address.';
                    }
                    field("Billing Address 2"; Rec."Billing Address 2")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Billing Address 2 which is used for additional billing address information.';
                    }
                    field("Billing City"; Rec."Billing City")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Billing City which is used for the invoice city.';
                    }
                    field("Billing Post Code"; Rec."Billing Post Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Billing Post Code which is used for the invoice postal code.';
                    }
                    field("Billing Country Code"; Rec."Billing Country Code")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the Billing Country Code which is used for the invoice country.';
                    }
                }
            }

            group(Totals)
            {
                Caption = 'Totals';

                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Currency which is used for the currency of the order.';
                }
                field("Order Subtotal"; Rec."Order Subtotal")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Order Subtotal which is used for the total before tax and shipping.';
                }
                field("Tax Amount"; Rec."Tax Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Tax Amount which is used for the total tax amount.';
                }
                field("Discount Amount"; Rec."Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Discount Amount which is used for the total discount applied.';
                }
                field("Shipping Cost"; Rec."Shipping Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Cost which is used for the shipping charges.';
                }
                field("Order Total"; Rec."Order Total")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Order Total which is used for the final total including all charges.';
                    Style = Strong;
                }
            }

            group(PaymentShipping)
            {
                Caption = 'Payment & Shipping';

                field("Payment Method"; Rec."Payment Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Payment Method which is used for how the customer paid.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Payment Reference which is used for the payment transaction reference.';
                }
                field("Payment Status"; Rec."Payment Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Payment Status which is used for the status of the payment.';
                }
                field("Shipping Method"; Rec."Shipping Method")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Shipping Method which is used for how the order will be delivered.';
                }
            }

            group(Notes)
            {
                Caption = 'Notes';

                field("Customer Note"; Rec."Customer Note")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer Note which is used for notes provided by the customer.';
                    MultiLine = true;
                }
                field("Internal Note"; Rec."Internal Note")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Internal Note which is used for internal processing notes.';
                    MultiLine = true;
                }
            }

            part(Lines; "DEF Webshop Lines Part")
            {
                ApplicationArea = All;
                Caption = 'Order Lines';
                SubPageLink = "Webshop Order No." = field("Webshop Order No.");
            }
        }
    }
}