# Active Context

## Current Focus
The project is currently in **Phase 1: Data Structure**. The primary focus is setting up the database tables to receive data from the external webshop.

## Recent Changes
*   **2025-12-07:**
    *   Created `DEF Webshop Header Staging` table (ID 50100).
    *   Created `DEF Webshop Line Staging` table (ID 50101).
    *   Established the Memory Bank structure (`projectbrief.md`, `productContext.md`, `systemPatterns.md`, `techContext.md`, `activeContext.md`).

## Next Steps
1.  **Phase 2: User Interface (UI)**
    *   Create List Page for Header Staging.
    *   Create Card Page for Header Staging.
    *   Create ListPart Page for Line Staging.
2.  **Phase 3: API Layer**
    *   Create API Pages for Header and Line tables.

## Active Decisions
*   **Staging Pattern:** Confirmed use of "loose" staging tables with `Text` fields to minimize ingestion errors.
*   **No Automatic Retries:** The system will rely on manual correction and re-processing by users rather than automated retry logic for validation errors.