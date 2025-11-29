# AL Performance Rules

## 1. Database Operations
- **Existence Checks:** Use `if Rec.IsEmpty() then...` (Faster than Count/FindFirst).
- **Partial Records:** Use `Rec.SetLoadFields(Field1, Field2)` before any `FindSet()` loop.
- **FindSet:** Always use `if Rec.FindSet() then repeat`. Avoid `Find('-')`.

## 2. FlowFields
- **CalcFields:** Always explicitly call `Rec.CalcFields()` before accessing FlowFields.
