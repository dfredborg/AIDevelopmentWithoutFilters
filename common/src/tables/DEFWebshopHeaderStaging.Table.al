table 50100 "DEF Webshop Header Staging TDY"
{
    Caption = 'DEF Webshop Header Staging';
    DataClassification = CustomerContent;

    fields
    {
        // Primary Key
        field(1; "Webshop Order No."; Text[100])
        {
            Caption = 'Webshop Order No.';
        }

        // General
        field(10; "Order Date"; Text[1024])
        {
            Caption = 'Order Date';
        }

        // Customer Information
        field(20; "Customer Email"; Text[1024])
        {
            Caption = 'Customer Email';
        }
        field(21; "Customer Name"; Text[1024])
        {
            Caption = 'Customer Name';
        }
        field(22; "Customer Phone"; Text[1024])
        {
            Caption = 'Customer Phone';
        }

        // Billing Address
        field(30; "Billing Name"; Text[1024])
        {
            Caption = 'Billing Name';
        }
        field(31; "Billing Address"; Text[1024])
        {
            Caption = 'Billing Address';
        }
        field(32; "Billing Address 2"; Text[1024])
        {
            Caption = 'Billing Address 2';
        }
        field(33; "Billing City"; Text[1024])
        {
            Caption = 'Billing City';
        }
        field(34; "Billing Post Code"; Text[1024])
        {
            Caption = 'Billing Post Code';
        }
        field(35; "Billing Country Code"; Text[1024])
        {
            Caption = 'Billing Country Code';
        }

        // Shipping Address
        field(40; "Shipping Name"; Text[1024])
        {
            Caption = 'Shipping Name';
        }
        field(41; "Shipping Address"; Text[1024])
        {
            Caption = 'Shipping Address';
        }
        field(42; "Shipping Address 2"; Text[1024])
        {
            Caption = 'Shipping Address 2';
        }
        field(43; "Shipping City"; Text[1024])
        {
            Caption = 'Shipping City';
        }
        field(44; "Shipping Post Code"; Text[1024])
        {
            Caption = 'Shipping Post Code';
        }
        field(45; "Shipping Country Code"; Text[1024])
        {
            Caption = 'Shipping Country Code';
        }

        // Payment and Shipping
        field(50; "Payment Method"; Text[1024])
        {
            Caption = 'Payment Method';
        }
        field(51; "Payment Reference"; Text[1024])
        {
            Caption = 'Payment Reference';
        }
        field(52; "Payment Status"; Text[1024])
        {
            Caption = 'Payment Status';
        }
        field(53; "Shipping Method"; Text[1024])
        {
            Caption = 'Shipping Method';
        }
        field(54; "Shipping Cost"; Text[1024])
        {
            Caption = 'Shipping Cost';
        }

        // Totals
        field(60; Currency; Text[1024])
        {
            Caption = 'Currency';
        }
        field(61; "Order Total"; Text[1024])
        {
            Caption = 'Order Total';
        }
        field(62; "Order Subtotal"; Text[1024])
        {
            Caption = 'Order Subtotal';
        }
        field(63; "Tax Amount"; Text[1024])
        {
            Caption = 'Tax Amount';
        }
        field(64; "Discount Amount"; Text[1024])
        {
            Caption = 'Discount Amount';
        }

        // Notes
        field(70; "Customer Note"; Text[1024])
        {
            Caption = 'Customer Note';
        }
        field(71; "Internal Note"; Text[1024])
        {
            Caption = 'Internal Note';
        }

        // System Fields
        field(80; Status; Option)
        {
            Caption = 'Status';
            OptionMembers = Pending,Completed,Error;
            OptionCaption = 'Pending,Completed,Error';
        }
        field(81; "Error Message"; Text[2048])
        {
            Caption = 'Error Message';
        }
    }

    keys
    {
        key(PK; "Webshop Order No.")
        {
            Clustered = true;
        }
    }
}