# System Patterns

## Architecture
The system follows a **Staging Table Pattern** (also known as an Interface Table pattern) to integrate external data.

### Components
1.  **Staging Tables (`DEF Webshop Header Staging`, `DEF Webshop Line Staging`):**
    *   Act as a buffer between the external API and internal Business Central logic.
    *   Use `Text` data types for almost all fields to prevent ingestion errors.
    *   Include status tracking (`Pending`, `Completed`, `Error`) and error logging fields.
2.  **API Pages:**
    *   Expose the Staging Tables as OData/REST endpoints.
    *   Allow standard CRUD operations (primarily Create).
    *   Include an Unbound Action (`processOrder`) to trigger processing immediately after upload.
3.  **Processing Codeunit:**
    *   Contains the business logic to validate and transform Staging data into Sales Documents.
    *   Handles error trapping to ensure the process doesn't crash, but instead updates the Staging record status.
4.  **UI Pages:**
    *   Standard List and Card pages for users to view and correct Staging data.

## Design Patterns

### Loose Coupling
The external system does not need to know about Business Central's internal validation rules (e.g., that a Customer No. must exist). It simply dumps the data it has, and Business Central handles the mapping and validation internally.

### Error Handling Strategy
*   **Ingestion:** Failures should be rare (only if the JSON structure is invalid or the API is down).
*   **Processing:** Failures are expected (e.g., new customer, unknown item). These are caught, logged to the Staging record, and the status is set to `Error`.
*   **Retry:** No automatic retries. Users manually correct data and re-trigger the process.

### Naming Conventions
*   **Prefix:** All objects use the `DEF` prefix.
*   **ID Range:** `50100..50200`.
*   **Table Names:** `DEF Webshop Header Staging`, `DEF Webshop Line Staging`.

## Technical Standards
*   **Data Types:** Use `Text[1024]` for staging fields to accommodate varying input lengths and formats.
*   **Keys:** Primary Key for Header is `Webshop Order No.`. Primary Key for Line is `Webshop Order No., Line No.`.
*   **Table Relations:** Lines are linked to Headers via `Webshop Order No.`.