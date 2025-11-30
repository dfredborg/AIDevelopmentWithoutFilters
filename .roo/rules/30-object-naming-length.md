# Object Naming Length

## 1. Maximum Length Constraint
- **Rule:** Object names (Tables, Pages, Codeunits, etc.) must NOT exceed 30 characters.
- **Reason:** Business Central has internal length limitations and excessively long names harm readability.
- **Enforcement:** This includes the prefix (e.g., `DEF`).

## 2. Examples

### ✅ Valid Names
- `DEF Sales Order Processing` (27 characters including prefix)
- `DEF Customer Ledger Entry` (25 characters)
- `DEF Setup` (9 characters)

### ❌ Invalid Names
- `DEF Sales Order Processing And Validation Logic` (50 characters - TOO LONG)
- `DEF Customer Information Management System` (43 characters - TOO LONG)

## 3. Best Practices
- Use abbreviations when necessary (e.g., `Mgt` for Management, `Calc` for Calculation).
- Remove unnecessary words like "And", "The", "Processing" if they don't add value.
- Prioritize clarity over verbosity.