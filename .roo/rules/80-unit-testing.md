# Unit Test Location

## 1. Core Concept
- **Rule:** Create unit tests for all code; these tests must be placed in the Test app.
- **Test App Location:** `apps/MyCoreApp.Test`
- **Goal:** Maintain clear separation between production and test code.

## 2. Test App Structure

### Directory Organization
```
apps/MyCoreApp.Test/
├── app.json
├── AppSourceCop.json
├── src/
│   └── codeunits/
│       ├── [TestCodeunit1].Codeunit.al
│       ├── [TestCodeunit2].Codeunit.al
│       └── ...
```

### Test Codeunit Naming
- **Pattern:** `DEF [Feature] Test.Codeunit.al`
- **Examples:**
  - `DEF Sales Calc Test.Codeunit.al`
  - `DEF Discount Logic Test.Codeunit.al`

## 3. Test Codeunit Structure

### Basic Template
```al
codeunit 50100 "DEF Sales Calc Test"
{
    Subtype = Test;
    
    [Test]
    procedure TestCalculateTotal()
    var
        SalesCalc: Codeunit "DEF Sales Calc";
        Result: Decimal;
    begin
        // [GIVEN] Setup test data
        
        // [WHEN] Execute the operation
        Result := SalesCalc.CalculateTotal(100, 0.1);
        
        // [THEN] Verify the result
        Assert.AreEqual(110, Result, 'Total should be 110');
    end;
}
```

## 4. Guidelines

### Test Coverage
- **Mandatory:** Every Codeunit with business logic must have corresponding tests.
- **Coverage Goal:** Aim for high test coverage of critical business logic.
- **Scope:** Test both positive and negative scenarios (happy path and error cases).

### Test Organization
- **One Test File per Production File:** Mirror the structure of `apps/MyCoreApp/src/` in your test app.
- **Group Related Tests:** Use test procedures to group related test cases within a test codeunit.

### Test Data
- **Isolation:** Each test should create its own test data and clean up afterward.
- **No Dependencies:** Tests should not depend on external data or other tests.
- **Fixtures:** Use helper procedures to create common test data.

## 5. Examples

### ✅ Good Test Structure
```
apps/MyCoreApp.Test/src/codeunits/
├── DEFSalesCalcTest.Codeunit.al          // Tests for DEF Sales Calc
├── DEFDiscountLogicTest.Codeunit.al      // Tests for DEF Discount Logic
└── DEFValidationTest.Codeunit.al         // Tests for DEF Validation
```

### ❌ Bad Test Structure
```
apps/MyCoreApp/src/codeunits/
├── DEFSalesCalc.Codeunit.al
├── DEFSalesCalcTest.Codeunit.al          // ❌ Tests in production app
```

## 6. app.json Configuration

### Test App Dependencies
The Test app (`apps/MyCoreApp.Test/app.json`) must reference the main app:
```json
{
  "id": "...",
  "name": "MyCoreApp.Test",
  "dependencies": [
    {
      "id": "...",
      "name": "MyCoreApp",
      "publisher": "Your Company",
      "version": "1.0.0.0"
    }
  ]
}
```

## 7. Running Tests
- **Local Testing:** Use the AL Test Tool extension in VS Code.
- **CI/CD:** Configure automated test execution in your deployment pipeline.
- **Test Reports:** Generate test reports to track coverage and results.

## 8. Benefits
- **Separation:** Keep test code separate from production code.
- **No Bloat:** Production app stays lean without test dependencies.
- **Easy Deployment:** Deploy production app without test code.
- **Independent Versioning:** Test app can evolve independently.