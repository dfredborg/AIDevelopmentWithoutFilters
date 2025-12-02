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
- Implement validation logic (e.g., finding Customer No. by Email, Item No. by SKU).
- Implement error handling:
  - Wrap processing in a way that captures errors.
  - Update Staging Status to `Error` and populate `Error Message` on failure.
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
| 50100 | `DEF Webshop Header Staging` | Stores raw order header data. Fields: Order ID, Customer Info, Dates, Status, Error Message. |
| 50101 | `DEF Webshop Line Staging` | Stores raw order line data. Linked to Header. Fields: SKU, Quantity, Price. |

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

## Questions & Clarifications

Before proceeding with the detailed AL coding, the following points need clarification:

1.  **Field Mapping:**
    *   Which specific fields from the webshop need to be mapped to the Sales Header? (e.g., External Document No., Requested Delivery Date, Ship-to Address details).
    *   How should we identify the Customer? (e.g., by Email, Phone No., or a specific Webshop ID stored in a custom field on the Customer card?)
    *   How should we identify Items? (e.g., by No., GTIN, or Vendor Item No.?)

2.  **Error Handling:**
    *   Should the system send an email notification to an administrator when a staging record fails to process?
    *   Do we need a retry mechanism for specific types of errors (e.g., record locking)?

3.  **API Authentication:**
    *   Will the external webshop use OAuth2 or Basic Auth (Web Service Access Key)? This affects how we document the connection setup, though not necessarily the AL code itself.

4.  **Sales Document Type:**
    *   Should these be created as `Sales Orders` or `Sales Quotes` initially?

5.  **Number Series:**
    *   Should the created Sales Documents use the standard Number Series, or should we try to force the Webshop Order ID as the Sales Order No. (if compatible)?