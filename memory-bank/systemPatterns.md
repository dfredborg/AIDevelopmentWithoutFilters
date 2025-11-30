# System Patterns

## Architecture
The solution follows a **Staging Table Pattern** common in ERP integrations.
1.  **External System (Webshop):** Pushes raw data via OData/API.
2.  **API Layer:** Exposes Staging Tables as standard APIs. Accepts `Text` data to minimize validation errors at the gateway.
3.  **Staging Layer:** Stores raw data in Business Central tables (`DEF Webshop Order Header`, `DEF Webshop Order Line`).
4.  **Processing Layer:** A Codeunit (`DEF Webshop Processing`) reads staging records, validates business logic (Customer exists, Item exists), parses data types, and creates standard Sales Documents.
5.  **Core Business Central:** Standard Sales Header and Sales Line tables.

## Design Patterns
*   **Prefixing:** All objects use `DEF` prefix.
*   **Namespace:** `MyCompany.Webshop` used for all AL files.
*   **Feature-Based Folders:** Code is organized by feature (`src/Webshop/`) rather than object type.
*   **TryFunction / Error Handling:** Processing logic captures errors and updates the Staging Record status instead of throwing a hard error that rolls back the transaction (unless critical).
*   **No Implicit With:** Explicit `Rec.` usage is enforced.
*   **Testability:** Business logic is isolated in Codeunits, not Pages, to facilitate Unit Testing.

## Data Flow
`Webshop JSON` -> `API Page` -> `Staging Table (Text)` -> `Processing Codeunit` -> `Sales Header/Line`

## Key Constraints
*   **Object IDs:** `50100` - `50200`
*   **Target Version:** BC 27.0
*   **App Publisher:** twoday