# Webshop Integration Implementation Plan

## Overview
This document outlines the implementation strategy for integrating an external webshop with Business Central using a Staging Pattern. The goal is to decouple the data reception from the business logic validation. External data will be received into "loose" staging tables (Text-based fields) via API, allowing for 100% successful data ingestion. A subsequent processing routine within Business Central will validate, transform, and convert this data into standard Sales Documents, handling errors gracefully without blocking the initial transfer.

## Phases

### Phase 1: Data Structure (Staging Tables)
Create the database structure to hold the raw incoming data.
- Define Header and Line tables.
- Use `Text[1024]` for data fields to prevent truncation or type mismatch errors during ingestion.
- Implement status tracking (`Pending`, `Completed`, `Error`) and error logging fields.

### Phase 2: User Interface (UI)
Provide a way for users to view and correct data issues manually.
- Create a List Page for the Header Staging table.
- Create a Card Page for the Header Staging table with a Subpart for Lines.
- Ensure fields are editable to allow manual corrections of validation errors.

### Phase 3: API Layer
Expose the staging tables to the external webshop.
- Create API Pages for both Header and Line tables.
- Ensure the API allows for standard CRUD operations (specifically Create).

### Phase 4: Processing Logic
Implement the business logic to transform Staging data into Sales Documents.
- Create a processing Codeunit.
- Target Document Type: **Sales Order**.
- Number Series: Use the **Standard Number Series** defined in Sales & Receivables Setup.
- Implement validation logic (e.g., finding Customer No. by Email, Item No. by SKU).
- Implement error handling:
  - Wrap processing in a way that captures errors.
  - Update Staging Status to `Error` and populate `Error Message` on failure.
  - **No email notifications** and **no automatic retries** will be implemented.
  - The workflow relies on the user manually correcting data in the Staging pages and re-triggering the process.
  - Update Staging Status to `Completed` on success.

### Phase 5: Execution & Automation
Enable triggering the processing logic.
- Add a "Process" action to the Staging Page UI.
- Create an Unbound Action in the API to allow the webshop to trigger processing immediately after upload.

## Technical Specifications

All objects will follow the `DEF` prefix and reside in the `50100..50200` ID range.

### Tables
| ID | Name | Description |
| :--- | :--- | :--- |
| 50100 | `DEF Webshop Header Staging` | Stores raw order header data. <br> **Primary Key:** Webshop Order No. <br> **Fields:** <br> - **General:** Webshop Order No., Order Date <br> - **Customer:** Customer Email, Customer Name, Customer Phone <br> - **Billing Address:** Name, Address, Address 2, City, Post Code, Country Code <br> - **Shipping Address:** Name, Address, Address 2, City, Post Code, Country Code <br> - **Payment/Shipping:** Payment Method, Payment Reference, Payment Status, Shipping Method, Shipping Cost <br> - **Totals:** Currency, Order Total, Order Subtotal, Tax Amount, Discount Amount <br> - **Notes:** Customer Note, Internal Note <br> - **System:** Status, Error Message |
| 50101 | `DEF Webshop Line Staging` | Stores raw order line data. Linked to Header. <br> **Primary Key:** Webshop Order No., Line No. <br> **Table Relation:** Webshop Order No. -> DEF Webshop Header Staging <br> **Fields:** <br> - **Link:** Webshop Order No. <br> - **Line Info:** Line No., Webshop Product ID, Product SKU, Description <br> - **Values:** Quantity, Unit Price, Line Amount, Discount Percent, Discount Amount, Tax Percent, Tax Amount |

### Pages (UI)
| ID | Name | Description |
| :--- | :--- | :--- |
| 50102 | `DEF Webshop Header List` | List view for `DEF Webshop Header Staging`. |
| 50103 | `DEF Webshop Header Card` | Card view for `DEF Webshop Header Staging`. |
| 50104 | `DEF Webshop Lines Part` | ListPart for `DEF Webshop Line Staging` (Subpage). |

### Pages (API)
| ID | Name | Description |
| :--- | :--- | :--- |
| 50105 | `DEF Webshop Header API` | API endpoint for Header Staging. Includes Unbound Action `processOrder`. |
| 50106 | `DEF Webshop Line API` | API endpoint for Line Staging. |

### Codeunits
| ID | Name | Description |
| :--- | :--- | :--- |
| 50107 | `DEF Webshop Processing` | Contains logic to validate staging data and create `Sales Header` / `Sales Line`. |
