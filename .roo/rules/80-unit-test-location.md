# Unit Test Location

## Rule
Create unit tests for all code, and place them in the Test app at `apps/MyCoreApp.Test`.

## Structure

### Test App Location
- **Path:** `apps/MyCoreApp.Test`
- **Purpose:** Isolated test environment for all unit tests
- **Convention:** Mirror the structure of the main app

### Test File Organization
```
apps/MyCoreApp.Test/
├── src/
│   └── codeunits/
│       ├── DEFSalesLogic.Test.al
│       ├── DEFSalesCalculator.Test.al
│       └── DEFSalesValidation.Test.al
```

## Naming Conventions

### Test Codeunits
- **Pattern:** `DEF[Object Name].Test.al`
- **Object Type:** Always Codeunit with Subtype = Test
- **Example:** `codeunit 50150 "DEF Sales Logic Test"`

### Test Procedures
- **Pattern:** `[MethodName]_[Scenario]_[ExpectedResult]`
- **Example:** `CalculateDiscount_PremiumCustomer_Returns10Percent`

## File Structure Example

```al
codeunit 50150 "DEF Sales Logic Test"
{
    Subtype = Test;

    [Test]
    procedure CalculateDiscount_PremiumCustomer_Returns10Percent()
    var
        SalesCalculator: Codeunit "DEF Sales Calculator";
        Result: Decimal;
    begin
        // Arrange
        // Act
        Result := SalesCalculator.CalculateDiscount(1000, "DEF Customer Type"::Premium);
        
        // Assert
        Assert.AreEqual(100, Result, 'Premium customer should get 10% discount');
    end;
}
```

## Test App Configuration

### app.json
```json
{
  "id": "...",
  "name": "MyCoreApp.Test",
  "publisher": "...",
  "version": "1.0.0.0",
  "dependencies": [
    {
      "id": "...",
      "name": "MyCoreApp",
      "publisher": "...",
      "version": "1.0.0.0"
    }
  ],
  "test": "1.0.0.0"
}
```

## Guidelines

### Separation
- **Main App:** Production code only (`apps/MyCoreApp`)
- **Test App:** Test code only (`apps/MyCoreApp.Test`)
- **Reason:** Keeps test code separate from production deployment

### Coverage
- **Target:** Write tests for all business logic
- **Priority:** Focus on codeunits with calculations, validations, and transformations
- **Skip:** Simple data access or UI-only procedures (unless complex logic involved)

### Dependencies
- **Test App:** References the main app
- **Main App:** Never references the test app

## Benefits
- **Clean Separation:** Test code doesn't bloat production app
- **Independent Deployment:** Production app can be deployed without tests
- **Clear Organization:** Easy to locate and maintain tests
- **CI/CD Ready:** Test app can be run separately in automated pipelines