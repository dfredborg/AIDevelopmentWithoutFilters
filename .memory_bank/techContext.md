# Tech Context

## Technology Stack
*   **Platform:** Microsoft Dynamics 365 Business Central
*   **Version:** 27.0 (Target: Cloud)
*   **Language:** AL (Application Language)
*   **Runtime:** 16.0

## Development Environment
*   **IDE:** Visual Studio Code
*   **Extensions:** AL Language Extension
*   **Linter:** AppSourceCop (Enabled)
*   **Configuration:**
    *   `NoImplicitWith`: Enabled
    *   `NoPromotedActionProperties`: Enabled

## Dependencies
*   **Base Application:** Standard Business Central application.
*   **System Application:** Core system libraries.
*   *(No external app dependencies listed in `app.json`)*

## Integration Architecture
*   **Protocol:** OData V4 / REST API (Standard Business Central APIs)
*   **Authentication:** OAuth2 (Standard for Cloud) or Basic Auth (Web Service Access Key - Deprecated but possible for specific scenarios, though OAuth is preferred).
*   **Data Format:** JSON

## Key Technical Constraints
*   **Object IDs:** Restricted to `50100..50200`.
*   **Field Types:** Staging tables use `Text[1024]` for maximum flexibility during ingestion.
*   **API Limits:** Standard Business Central API limits apply (rate limiting, payload size).