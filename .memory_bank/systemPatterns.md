# System Patterns

## Architecture
The system follows a **Staging Table Pattern** (also known as an Interface Table pattern) to integrate external data.

### Components
1.  **Staging Tables:**
    *   `DEF Webshop Header Staging` (Table 50100)
    *   `DEF Webshop Line Staging` (Table 50101)
    *   **Pattern:** "Loose" typing (Text[1024]) to minimize ingestion errors. Status tracking (`Pending`, `Completed`, `Error`).
2.  **API Pages:**
    *   `DEF Webshop Header API` (Page 50105)
    *   `DEF Webshop Line API` (Page 50106)
    *   **Pattern:** Standard API pages exposing the staging tables. Future: Will include an Unbound Action to trigger processing.
3.  **UI Pages:**
    *   `DEF Webshop Header List` (Page 50102)
    *   `DEF Webshop Header Card` (Page 50103)
    *   `DEF Webshop Lines Part` (Page 50104)
    *   **Pattern:** Standard Business Central UI for manual error correction and review.
4.  **Processing Codeunit (Planned):**
    *   Will contain the business logic to validate and transform Staging data into Sales Documents.
    *   **Pattern:** Try-Function or Error trapping to update Staging status instead of rolling back the transaction.

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