# System Patterns

## Architecture: The Staging Pattern
The system follows a **Staging Pattern** architecture, divided into three distinct layers:

1.  **Ingestion Layer (API & Staging Tables):**
    *   **Goal:** High availability and fault tolerance for incoming data.
    *   **Mechanism:** API Pages expose Staging Tables.
    *   **Data Structure:** Fields are primarily `Text` types to accept any input without validation errors.
    *   **Components:** `DEF Webshop Header Staging`, `DEF Webshop Line Staging`, `DEF Webshop Header API`, `DEF Webshop Line API`.

2.  **Processing Layer (Business Logic):**
    *   **Goal:** Validate, transform, and convert data.
    *   **Mechanism:** A dedicated Codeunit processes staging records.
    *   **Logic:**
        *   Validates existence of master data (Customer, Item).
        *   Performs mapping (e.g., Email -> Customer No.).
        *   Creates standard Business Central documents (Sales Header, Sales Line).
    *   **Components:** `DEF Webshop Processing` Codeunit.

3.  **Presentation Layer (UI):**
    *   **Goal:** Visibility and manual error correction.
    *   **Mechanism:** Standard List and Card pages for Staging tables.
    *   **Components:** `DEF Webshop Header List`, `DEF Webshop Header Card`, `DEF Webshop Lines Part`.

## Design Patterns & Rules

### 1. Object ID Management
*   **Range:** `50100` to `50200`
*   **Strict Enforcement:** No objects outside this range.

### 2. Naming Conventions
*   **Prefix:** `DEF` (Global prefix for all objects).
*   **Length:** Maximum 30 characters (excluding prefix).
*   **Pattern:** `[Prefix] [Object Name]` (e.g., `DEF Webshop Header`).
*   **Files:** `[Prefix][ObjectName].[ObjectType].al` (e.g., `DEFWebshopHeader.Table.al`).

### 3. Single Responsibility Principle (SRP)
*   **Tables:** Store data only. No complex logic.
*   **Pages:** Display data only. No business logic in triggers.
*   **Codeunits:** Contain all business logic.
    *   `DEF Webshop Processing`: Handles the conversion logic.
    *   Separate validation logic if complexity grows.

### 4. Namespace Strategy
*   **Requirement:** All files must define a namespace.
*   **Structure:** Matches folder structure (e.g., `namespace MyCompany.Sales.Integration;`).

### 5. Testability
*   **Dependency Injection:** Logic should be decoupled to allow for unit testing.
*   **Test App:** All tests reside in `apps/MyCoreApp.Test`.

### 6. Singleton Pattern
*   **Usage:** If a setup table is required (e.g., `DEF Webshop Setup`), use the Singleton pattern (Get/Init/Insert) to ensure a single configuration record exists.

## Folder Structure
The project follows a feature-based folder structure:
```
apps/MyCoreApp/src/
├── Integration/
│   ├── Webshop/
│   │   ├── Tables/
│   │   ├── Pages/
│   │   ├── API/
│   │   └── Codeunits/
```
*(Note: While the rules suggest grouping by feature, subfolders for object types within a feature are acceptable for clarity if the feature is large, but the primary grouping is the Feature "Webshop".)*