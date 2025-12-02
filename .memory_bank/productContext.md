# Product Context

## Why This Project Exists
Integrating external systems with an ERP like Business Central is notoriously difficult due to strict data validation rules. Direct integrations often fail because the external system sends data that doesn't perfectly match the ERP's expectations (e.g., a slightly misspelled customer name, an unknown SKU, or a date format mismatch). When these direct API calls fail, the order is lost or stuck in the external system, requiring IT intervention to fix.

This project solves that problem by introducing a **Staging Layer**. Instead of rejecting imperfect data, Business Central accepts *everything* into a temporary holding area. This shifts the responsibility of error resolution from the external system (which often can't handle it) to the internal ERP users (who have the context and tools to fix it).

## Problem Statement
*   **Data Loss:** Direct API failures can lead to lost orders.
*   **Tight Coupling:** Changes in Business Central validation logic can break the external webshop integration.
*   **Operational Friction:** IT support is often required to debug API logs when orders fail to sync.
*   **Rigidity:** External systems are forced to know too much about internal ERP logic (e.g., exact Customer Numbers).

## Solution Strategy
The "Staging Pattern" implementation:
1.  **Accepts All Data:** The API endpoint writes to a Staging Table with loose validation (text fields).
2.  **Asynchronous Processing:** A background or user-triggered process validates the data.
3.  **User-Centric Error Resolution:** If validation fails (e.g., "Customer not found"), the record is marked as `Error`, and a clear message is displayed. A user can then map the customer manually in the Staging UI and retry processing.
4.  **Traceability:** Every incoming order has a record in the Staging table, providing a complete audit trail of what was received versus what was processed.

## User Experience
*   **Webshop Admin:** "I just send the order JSON to the endpoint. I get a 201 Created response immediately. I don't have to worry about BC validation errors."
*   **BC Sales Processor:** "I see a list of incoming webshop orders. Most are green (Completed). If I see a red one (Error), I open it, read the error message (e.g., 'Unknown Item SKU'), fix the SKU on the line, and click 'Process' again. The order is created, and the staging record turns green."