# Singleton Design Pattern

## Rule
Use the Singleton design pattern where applicable to ensure a class has only one instance.

## When to Use
- **Setup/Configuration Tables:** When you need exactly one record (e.g., "Sales & Receivables Setup").
- **Global State Management:** When managing application-wide settings or state.
- **Resource Management:** When controlling access to a shared resource.

## Implementation in AL

### For Setup Tables
```al
table 50100 "DEF Sales Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(2; "Default Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Default Customer No.';
        }
    }

    keys
    {
        key(PK; "Primary Key") { }
    }
}
```

### Accessing Setup (Singleton Pattern)
```al
codeunit 50100 "DEF Sales Logic"
{
    procedure GetSetup(): Record "DEF Sales Setup"
    var
        SalesSetup: Record "DEF Sales Setup";
    begin
        if not SalesSetup.Get() then begin
            SalesSetup.Init();
            SalesSetup.Insert();
        end;
        exit(SalesSetup);
    end;
}
```

## Guidelines
- **Primary Key:** Setup tables typically have a single primary key field.
- **Get Pattern:** Always use a Get/Initialize pattern to ensure the record exists.
- **No Delete:** Setup records should generally not be deletable through standard UI.

## Examples

### ✅ Correct
```al
// Always check and initialize if needed
procedure ProcessSales()
var
    SalesSetup: Record "DEF Sales Setup";
begin
    if not SalesSetup.Get() then begin
        SalesSetup.Init();
        SalesSetup.Insert();
    end;
    // Use SalesSetup here
end;
```

### ❌ Incorrect
```al
// Assuming the record exists
procedure ProcessSales()
var
    SalesSetup: Record "DEF Sales Setup";
begin
    SalesSetup.FindFirst();  // May fail if record doesn't exist
    // Use SalesSetup here
end;
```

## Benefits
- **Guaranteed State:** Ensures configuration/setup is always available.
- **Controlled Access:** Single point of access to global settings.
- **Predictable Behavior:** No uncertainty about which instance to use.