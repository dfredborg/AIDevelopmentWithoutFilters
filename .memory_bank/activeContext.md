# Active Context

## Current Focus
The project has completed **Phase 1: Data Structure**, **Phase 2: User Interface**, and **Phase 3: API Layer**. The primary focus is now **Phase 4: Processing Logic**, specifically creating the Codeunit to validate and transform the staging data into Sales Orders.

## Recent Changes
*   **2025-12-10:**
    *   Created `DEF Webshop Header List` (Page 50102).
    *   Created `DEF Webshop Header Card` (Page 50103).
    *   Created `DEF Webshop Lines Part` (Page 50104).
    *   Created `DEF Webshop Header API` (Page 50105).
    *   Created `DEF Webshop Line API` (Page 50106).
*   **2025-12-07:**
    *   Created `DEF Webshop Header Staging` table (ID 50100).
    *   Created `DEF Webshop Line Staging` table (ID 50101).
    *   Established the Memory Bank structure.

## Next Steps
1.  **Phase 4: Processing Logic**
    *   Create Processing Codeunit.
    *   Implement "Process" action on the Webshop Header Card/List.
    *   Implement validation logic (Find Customer, Find Item).
    *   Implement document creation logic (Sales Header, Sales Line).

## Active Decisions
*   **Staging Pattern:** Confirmed use of "loose" staging tables with `Text` fields to minimize ingestion errors.
*   **No Automatic Retries:** The system will rely on manual correction and re-processing by users rather than automated retry logic for validation errors.