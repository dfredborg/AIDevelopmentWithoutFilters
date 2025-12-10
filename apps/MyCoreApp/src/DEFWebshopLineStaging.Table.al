namespace fredborg.webshop;

table 50101 "DEF Webshop Line Staging TDY"
{
    Caption = 'DEF Webshop Line Staging';
    DataClassification = CustomerContent;

    fields
    {
        // Primary Key - Link to Header
        field(1; "Webshop Order No."; Text[100])
        {
            Caption = 'Webshop Order No.';
            TableRelation = "DEF Webshop Header Staging TDY"."Webshop Order No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }

        // Line Information
        field(10; "Webshop Product ID"; Text[1024])
        {
            Caption = 'Webshop Product ID';
        }
        field(11; "Product SKU"; Text[1024])
        {
            Caption = 'Product SKU';
        }
        field(12; Description; Text[1024])
        {
            Caption = 'Description';
        }

        // Values
        field(20; Quantity; Text[1024])
        {
            Caption = 'Quantity';
        }
        field(21; "Unit Price"; Text[1024])
        {
            Caption = 'Unit Price';
        }
        field(22; "Line Amount"; Text[1024])
        {
            Caption = 'Line Amount';
        }
        field(23; "Discount Percent"; Text[1024])
        {
            Caption = 'Discount Percent';
        }
        field(24; "Discount Amount"; Text[1024])
        {
            Caption = 'Discount Amount';
        }
        field(25; "Tax Percent"; Text[1024])
        {
            Caption = 'Tax Percent';
        }
        field(26; "Tax Amount"; Text[1024])
        {
            Caption = 'Tax Amount';
        }
    }

    keys
    {
        key(PK; "Webshop Order No.", "Line No.")
        {
            Clustered = true;
        }
    }
}