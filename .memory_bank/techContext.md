# Tech Context

## Technologies
*   **Platform:** Microsoft Dynamics 365 Business Central (AL Language).
*   **Integration Method:** REST API (OData V4).
*   **Data Format:** JSON.

## Development Environment
*   **Language:** AL (Application Language).
*   **IDE:** Visual Studio Code with AL Language extension.
*   **Version Control:** Git.

## Dependencies
*   **Standard Business Central Modules:**
    *   Sales & Receivables (Sales Header, Sales Line).
    *   No. Series Management.

## Configuration
*   **ID Range:** `50100..50200`.
*   **Prefix:** `DEF`.

## Project Structure
*   `src/`: Source code root.
    *   `tables/`: Table definitions (`.al` files).
    *   `pages/`: Page definitions (UI and API).
    *   `codeunits/`: Business logic.
*   `Implementation.md`: Detailed implementation plan.
*   `Progress.md`: Task tracking.
*   `payload.json`: Sample JSON payload for testing.