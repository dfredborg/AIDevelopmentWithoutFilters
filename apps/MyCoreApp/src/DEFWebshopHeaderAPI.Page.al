namespace fredborg.webshop;

page 50105 "DEF Webshop Header API"
{
    PageType = API;
    APIPublisher = 'myCompany';
    APIGroup = 'webshop';
    APIVersion = 'v1.0';
    EntityName = 'webshopOrder';
    EntitySetName = 'webshopOrders';
    SourceTable = "DEF Webshop Header Staging TDY";
    DelayedInsert = true;
    ODataKeyFields = "Webshop Order No.";

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
                field(orderDate; Rec."Order Date")
                {
                    Caption = 'Order Date';
                }
                field(customerEmail; Rec."Customer Email")
                {
                    Caption = 'Customer Email';
                }
                field(customerName; Rec."Customer Name")
                {
                    Caption = 'Customer Name';
                }
                field(customerPhone; Rec."Customer Phone")
                {
                    Caption = 'Customer Phone';
                }
                field(billingName; Rec."Billing Name")
                {
                    Caption = 'Billing Name';
                }
                field(billingAddress; Rec."Billing Address")
                {
                    Caption = 'Billing Address';
                }
                field(billingAddress2; Rec."Billing Address 2")
                {
                    Caption = 'Billing Address 2';
                }
                field(billingCity; Rec."Billing City")
                {
                    Caption = 'Billing City';
                }
                field(billingPostCode; Rec."Billing Post Code")
                {
                    Caption = 'Billing Post Code';
                }
                field(billingCountryCode; Rec."Billing Country Code")
                {
                    Caption = 'Billing Country Code';
                }
                field(shippingName; Rec."Shipping Name")
                {
                    Caption = 'Shipping Name';
                }
                field(shippingAddress; Rec."Shipping Address")
                {
                    Caption = 'Shipping Address';
                }
                field(shippingAddress2; Rec."Shipping Address 2")
                {
                    Caption = 'Shipping Address 2';
                }
                field(shippingCity; Rec."Shipping City")
                {
                    Caption = 'Shipping City';
                }
                field(shippingPostCode; Rec."Shipping Post Code")
                {
                    Caption = 'Shipping Post Code';
                }
                field(shippingCountryCode; Rec."Shipping Country Code")
                {
                    Caption = 'Shipping Country Code';
                }
                field(paymentMethod; Rec."Payment Method")
                {
                    Caption = 'Payment Method';
                }
                field(paymentReference; Rec."Payment Reference")
                {
                    Caption = 'Payment Reference';
                }
                field(paymentStatus; Rec."Payment Status")
                {
                    Caption = 'Payment Status';
                }
                field(shippingMethod; Rec."Shipping Method")
                {
                    Caption = 'Shipping Method';
                }
                field(shippingCost; Rec."Shipping Cost")
                {
                    Caption = 'Shipping Cost';
                }
                field(currency; Rec.Currency)
                {
                    Caption = 'Currency';
                }
                field(orderTotal; Rec."Order Total")
                {
                    Caption = 'Order Total';
                }
                field(orderSubtotal; Rec."Order Subtotal")
                {
                    Caption = 'Order Subtotal';
                }
                field(taxAmount; Rec."Tax Amount")
                {
                    Caption = 'Tax Amount';
                }
                field(discountAmount; Rec."Discount Amount")
                {
                    Caption = 'Discount Amount';
                }
                field(customerNote; Rec."Customer Note")
                {
                    Caption = 'Customer Note';
                }
                field(internalNote; Rec."Internal Note")
                {
                    Caption = 'Internal Note';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                    Editable = false;
                }
                field(errorMessage; Rec."Error Message")
                {
                    Caption = 'Error Message';
                    Editable = false;
                }
            }
            part(webshopOrderLines; "DEF Webshop Line API")
            {
                Caption = 'Order Lines';
                EntityName = 'webshopOrderLine';
                EntitySetName = 'webshopOrderLines';
                SubPageLink = "Webshop Order No." = field("Webshop Order No.");
            }
        }
    }
}