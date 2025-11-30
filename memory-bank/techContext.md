# Tech Context

## Technologies
*   **Language:** AL (Application Language) for Business Central.
*   **Platform:** Microsoft Dynamics 365 Business Central (Cloud).
*   **Version:** 27.0.0.0
*   **Runtime:** 16.0

## Development Environment
*   **IDE:** Visual Studio Code.
*   **Extensions:** AL Language Extension.
*   **Linter:** ALCop, AppSourceCop.

## Project Structure
*   **Root:** `c:/web`
*   **App:** `apps/MyCoreApp`
*   **Test App:** `apps/MyCoreApp.Test`
*   **Documentation:** `docs/`
*   **Rules:** `.roo/rules/`

## Configuration
*   **app.json:** Defines ID ranges (`50100-50200`), dependencies, and platform version.
*   **launch.json:** (Implicit) Controls deployment targets.

## Constraints
*   **File Naming:** `[Prefix][ObjectName].[ObjectType].al` (e.g., `DEFWebshopOrder.Table.al`).
*   **Object Naming:** Max 30 chars, including `DEF` prefix.
*   **Namespaces:** Mandatory, matching folder structure.
*   **Tooltips:** Mandatory for all page fields.
*   **ApplicationArea:** `#All` required for visibility.