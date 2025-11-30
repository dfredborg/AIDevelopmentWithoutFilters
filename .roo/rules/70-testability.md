# Testability

## 1. Core Concept
- **Rule:** All code must be designed to be easily testable by unit tests.
- **Goal:** Enable comprehensive automated testing to ensure code quality and prevent regressions.
- **Application:** Decouple business logic from UI and database dependencies.

## 2. Design Principles for Testability

### Separation of Concerns
- **Business Logic:** Should reside in Codeunits, not in Page triggers.
- **Data Access:** Isolate database operations to make them mockable or replaceable in tests.
- **UI Logic:** Keep presentation logic minimal; delegate to Codeunits for testing.

### Dependency Injection
- **Interfaces:** Use interfaces to define contracts for dependencies.
- **Procedure Parameters:** Pass dependencies as parameters instead of hardcoding them.
- **Example:**
  ```al
  // ✅ Testable - dependency is injected
  procedure CalculateDiscount(var SalesLine: Record "Sales Line"; DiscountEngine: Interface "IDiscount Calculator"): Decimal
  begin
      exit(DiscountEngine.Calculate(SalesLine));
  end;
  
  // ❌ Not testable - hardcoded dependency
  procedure CalculateDiscount(var SalesLine: Record "Sales Line"): Decimal
  var
      DiscountCalc: Codeunit "DEF Discount Calc";
  begin
      exit(DiscountCalc.Calculate(SalesLine));
  end;
  ```

## 3. Guidelines

### Codeunits
- **Pure Functions:** Prefer functions with inputs and outputs, avoiding side effects when possible.
- **Avoid Global State:** Do not rely on global variables unless using SingleInstance pattern intentionally.
- **Return Values:** Functions should return results instead of modifying global state.

### Pages
- **Minimal Logic:** Pages should only handle UI interactions and delegate to Codeunits.
- **Testable Actions:** Action triggers should call Codeunit procedures that can be tested independently.
- **Example:**
  ```al
  // ✅ Testable - logic in Codeunit
  trigger OnAction()
  var
      SalesMgt: Codeunit "DEF Sales Management";
  begin
      SalesMgt.ProcessOrder(Rec);
  end;
  
  // ❌ Not testable - logic in Page
  trigger OnAction()
  begin
      Rec.Validate("Order Status", Rec."Order Status"::Processed);
      Rec.Modify(true);
      Message('Order processed');
  end;
  ```

### Tables
- **Validation Logic:** Complex validation should be in Codeunits, not OnValidate triggers.
- **Calculation Logic:** Move calculations to dedicated Codeunits for testability.

## 4. Testing Strategies

### Unit Tests
- Test individual procedures in isolation.
- Use Test Codeunits with `[Test]` attributes.
- Mock external dependencies using interfaces.

### Integration Tests
- Test interactions between objects (e.g., Table and Codeunit).
- Use test data setup procedures for consistency.

## 5. Benefits
- **Regression Prevention:** Automated tests catch bugs before deployment.
- **Refactoring Confidence:** Tests ensure changes don't break existing functionality.
- **Documentation:** Tests serve as executable documentation of expected behavior.
- **Code Quality:** Testable code is typically better designed and more maintainable.

## 6. Anti-Patterns to Avoid

### ❌ Untestable Code
- Complex logic embedded in Page triggers.
- Direct database queries in UI code.
- Hardcoded dependencies that cannot be mocked.
- Global state that affects test isolation.

### ✅ Testable Code
- Business logic in Codeunits with clear inputs/outputs.
- Dependencies injected via interfaces or parameters.
- Minimal side effects; functions return results.
- State isolated to test scope.