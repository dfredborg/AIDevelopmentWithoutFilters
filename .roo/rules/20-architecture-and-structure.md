# Architecture & Folder Structure

## 1. Namespace Strategy
- **Requirement:** Every AL file MUST define a `namespace` at the top of the file.
- **Pattern:** The namespace must match the logical folder structure.
  - *Example:* If file is in `src/Sales/Setup/`, namespace is `namespace MyCompany.Sales.Setup;`

## 2. Folder Organization (Feature-Based)
- **Do Not:** Group files by Object Type (e.g., do not create a `src/Tables/` folder).
- **Do:** Group files by **Feature** or **Domain**.
  - `src/Vehicles/` contains the Table, Page, and Codeunit related to Vehicles.
  - `src/Sales/Posting/` contains the posting logic and extensions.

## 3. Separation of Concerns
- **Pages:** DISPLAY only. No complex business logic in triggers.
- **Codeunits:** Logic containers. Pages should call procedures in Codeunits.
