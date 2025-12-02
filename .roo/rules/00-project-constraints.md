# Critical Project Constraints

## 1. Object ID Management
* **Assigned Range:** `50100` to `50200`
* **Rule:** You MUST ONLY assign Object IDs within this range.
* **Strict Prohibition:** Do not use IDs outside this range (e.g., 50201 is FORBIDDEN).
* **Conflict Check:** Before creating a new object, check the file list to ensure the ID is not already taken.

## 2. Naming Conventions (Prefix)
* **Global Prefix:** `DEF`
* **Rule:** ALL new objects must start with the `DEF` prefix.
* **Examples:**
  * ✅ `codeunit 50100 "DEF Sales Calculation"`
  * ❌ `codeunit 50100 "Sales Calculation"`
  * ❌ `codeunit 50100 "DEF_Sales Calculation"` (Do not use underscores unless necessary)

## 3. Environment
* **Target Version:** Business Central 27.0 (Current) or higher.
* **Manifest:** Ensure `app.json` dependencies are respected.
