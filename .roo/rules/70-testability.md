# Testability

## Rule
All code must be designed to be easily testable by unit tests.

## Core Principles

### 1. Dependency Injection
- **Avoid:** Hard-coded dependencies that cannot be mocked.
- **Use:** Parameters and interfaces to allow test doubles.

### 2. Small, Focused Procedures
- **Rule:** Keep procedures small with a single, clear purpose.
- **Benefit:** Easier to test individual behaviors.

### 3. Avoid Global State
- **Rule:** Minimize reliance on global variables or state.
- **Use:** Pass dependencies explicitly through parameters.

### 4. Separation of Concerns
- **Rule:** Keep business logic separate from UI and database operations.
- **Benefit:** Logic can be tested independently.

## Code Design for Testability

### ✅ Testable Code
```al
// Good: Dependencies passed as parameters
codeunit 50100 "DEF Sales Calculator"
{
    procedure CalculateDiscount(SalesAmount: Decimal; CustomerType: Enum "DEF Customer Type"): Decimal
    var
        DiscountPct: Decimal;
    begin
        case CustomerType of
            CustomerType::Premium:
                DiscountPct := 10;
            CustomerType::Standard:
                DiscountPct := 5;
            else
                DiscountPct := 0;
        end;
        exit(SalesAmount * DiscountPct / 100);
    end;
}
```

### ❌ Hard to Test
```al
// Bad: Hard-coded dependencies and complex logic
codeunit 50100 "DEF Sales Manager"
{
    procedure ProcessOrder(OrderNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        Customer: Record Customer;
    begin
        SalesHeader.Get(SalesHeader."Document Type"::Order, OrderNo);
        Customer.Get(SalesHeader."Sell-to Customer No.");
        
        // Complex logic mixed with data access
        if (Customer."Customer Posting Group" = 'PREMIUM') and 
           (SalesHeader."Amount Including VAT" > 1000) then begin
            SalesHeader.Validate("Payment Discount %", 10);
            SalesHeader.Modify();
        end;
    end;
}
```

## Testing Guidelines

### Write Tests For
- **Business Logic:** All calculation, validation, and transformation logic.
- **Edge Cases:** Boundary conditions, empty values, null scenarios.
- **Error Handling:** Validate error messages and exception handling.

### Keep Tests Independent
- **No Dependencies:** Tests should not depend on each other.
- **Clean State:** Each test should set up and tear down its own data.

## Implementation Tips

### Use Interfaces
```al
// Define interface for testability
interface "DEF IDiscount Calculator"
{
    procedure CalculateDiscount(Amount: Decimal): Decimal;
}

// Implementation can be mocked in tests
codeunit 50100 "DEF Standard Discount" implements "DEF IDiscount Calculator"
{
    procedure CalculateDiscount(Amount: Decimal): Decimal
    begin
        exit(Amount * 0.05);
    end;
}
```

### Extract Business Logic
```al
// Separate data access from logic
codeunit 50101 "DEF Sales Logic"
{
    // Pure logic - easy to test
    procedure IsEligibleForDiscount(CustomerType: Text; OrderAmount: Decimal): Boolean
    begin
        exit((CustomerType = 'PREMIUM') and (OrderAmount > 1000));
    end;
}
```

## Benefits
- **Confidence:** Changes can be validated automatically.
- **Documentation:** Tests serve as executable specifications.
- **Quality:** Bugs are caught earlier in the development cycle.
- **Refactoring:** Code can be improved safely with test coverage.