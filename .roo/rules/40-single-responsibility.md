# Single Responsibility Principle (SRP)

## 1. Core Concept
- **Rule:** Each object (Table, Page, Codeunit, etc.) should have ONE clear responsibility.
- **Goal:** Improve maintainability, testability, and reduce coupling between components.
- **Application:** Design objects so that they have only one reason to change.

## 2. Examples in AL Development

### ✅ Good Design (SRP Applied)
- **`DEF Sales Calc` Codeunit:** Only handles sales calculations.
- **`DEF Sales Post` Codeunit:** Only handles sales posting logic.
- **`DEF Sales Validate` Codeunit:** Only handles sales validation.

### ❌ Bad Design (SRP Violated)
- **`DEF Sales Manager` Codeunit:** Contains calculations, posting, validation, reporting, and email sending.
  - *Problem:* Changes to any one feature affect the entire codeunit.

## 3. Guidelines

### Tables
- Each table should represent a single entity (e.g., Customer, Sales Header, Item).
- Do not mix unrelated data in one table.

### Codeunits
- **Single Purpose:** Each codeunit should focus on one domain operation.
- **Examples:**
  - `DEF Sales Calculation` - Only calculations
  - `DEF Email Sender` - Only email operations
  - `DEF Report Generator` - Only report generation

### Pages
- Pages should display and collect data for a single entity or purpose.
- Complex business logic should be delegated to Codeunits.

## 4. Benefits
- Easier to test individual components.
- Easier to maintain and debug.
- Reduces risk of breaking unrelated functionality when making changes.
- Improves code reusability.