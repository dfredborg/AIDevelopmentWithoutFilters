# Single Responsibility Principle (SRP)

## Rule
Follow the Single Responsibility Principle: Each object should have one, and only one, reason to change.

## Explanation
- **What:** Every codeunit, table, page, or other AL object should focus on a single, well-defined purpose.
- **Why:** This improves maintainability, testability, and makes code easier to understand and modify.

## Application Guidelines

### Codeunits
- **One Purpose:** Each codeunit should handle ONE specific responsibility.
- **Example:** Separate posting logic, validation logic, and calculation logic into different codeunits.

### Tables
- **Data Model:** Each table should represent a single entity or concept.
- **Avoid:** Mixing unrelated data in the same table.

### Pages
- **UI Responsibility:** Pages should focus on displaying and collecting data, not business logic.
- **Delegation:** Delegate complex operations to codeunits.

## Examples

### ✅ Correct
```al
// Separate responsibilities
codeunit 50100 "DEF Sales Validation"      // Only validation
codeunit 50101 "DEF Sales Calculation"     // Only calculations
codeunit 50102 "DEF Sales Posting"         // Only posting logic
```

### ❌ Incorrect
```al
// Multiple responsibilities in one codeunit
codeunit 50100 "DEF Sales Manager"
{
    // Validation, calculation, and posting all mixed together
    procedure ValidateOrder() { }
    procedure CalculateTotal() { }
    procedure PostSalesOrder() { }
}
```

## Benefits
- **Easier Testing:** Smaller, focused units are easier to test.
- **Better Maintainability:** Changes to one responsibility don't affect others.
- **Improved Reusability:** Focused codeunits can be reused in different contexts.