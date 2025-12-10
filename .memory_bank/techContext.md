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
*   `apps/MyCoreApp/src/`: Source code root.
    *   `DEFWebshopHeaderStaging.Table.al`: Header Staging Table.
    *   `DEFWebshopLineStaging.Table.al`: Line Staging Table.
    *   `DEFWebshopHeaderList.Page.al`: Header List Page.
    *   `DEFWebshopHeaderCard.Page.al`: Header Card Page.
    *   `DEFWebshopLinesPart.Page.al`: Lines ListPart Page.
    *   `DEFWebshopHeaderAPI.Page.al`: Header API Page.
    *   `DEFWebshopLineAPI.Page.al`: Line API Page.
*   `common/Implementation.md`: Detailed implementation plan.
*   `common/payload.json`: Sample JSON payload for testing.