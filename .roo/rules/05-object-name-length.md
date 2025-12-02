# Object Name Length

## Rule
Object names must not be longer than 30 characters.

## Explanation
- **Why:** Business Central has limitations on object name lengths. Keeping names concise ensures compatibility and readability.
- **Enforcement:** Before creating any new AL object, ensure the name (excluding the prefix) does not exceed 30 characters.

## Examples

### ✅ Correct
```al
table 50100 "DEF Sales Setup"
page 50101 "DEF Customer Card"
codeunit 50102 "DEF Sales Logic"
```

### ❌ Incorrect
```al
table 50100 "DEF Very Long Sales Configuration Setup Table"  // Too long
page 50101 "DEF Customer Master Data Management Card"        // Too long
```

## Best Practices
- Use abbreviations when necessary (e.g., "Mgmt" instead of "Management").
- Prioritize clarity over verbosity.
- Remove unnecessary words like "Table", "Page", "Codeunit" from the object name itself.