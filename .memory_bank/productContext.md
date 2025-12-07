# Product Context

## Problem Statement
Integrating external systems (like webshops) directly with Business Central's transactional tables (e.g., Sales Header/Line) is prone to failure. Strict validation logic in Business Central (e.g., validating Customer No., Item No., or data types) often causes API calls to fail if the incoming data is imperfect or if reference data is missing. This results in lost orders or complex error handling requirements on the external system side.

## Solution Description
The solution implements a **Staging Pattern** to decouple data reception from business logic validation.

1.  **Reception:** Data is received into "loose" Staging Tables where almost all fields are defined as `Text` types. This ensures the API call succeeds even if data formats are slightly off or references don't exist yet.
2.  **Validation & Transformation:** A separate process (Codeunit) reads the staging data, validates it against Business Central logic (e.g., looking up customers by email), and transforms it into a standard Sales Order.
3.  **Error Handling:** If validation fails, the Staging record is marked with an `Error` status and an error message is logged. The process does *not* rollback the insertion of the staging record.
4.  **Correction:** Users can view the Staging records in a dedicated UI, manually correct the data (e.g., fix a typo in an email address), and re-trigger the processing logic.

## User Experience
*   **Webshop/API Client:** Sends a JSON payload to the API. Receives a `201 Created` response immediately, confirming receipt.
*   **BC User:**
    *   Navigates to "DEF Webshop Header List".
    *   Sees a list of incoming orders with statuses (`Pending`, `Completed`, `Error`).
    *   Filters for `Error` records to identify issues.
    *   Opens a record, reads the `Error Message`, corrects the field (e.g., `Customer Email`), and clicks the "Process" action.
    *   Verifies the status changes to `Completed` and a Sales Order is created.