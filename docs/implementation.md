# Webshop Integration Implementation Plan

This document outlines the technical implementation plan for the Webshop Integration feature. The goal is to provide a robust, fault-tolerant integration where external data is received into staging tables as text, validated, and then processed into Business Central Sales Documents.

## Project Constraints & Standards
*   **ID Range:** `50100` - `50200`
*   **Prefix:** `DEF`
*   **Namespace:** `MyCompany.Webshop`
*   **Root Folder:** `apps/MyCoreApp/src/Webshop/`

## Phase 1: Data Structure (Staging Tables)

Create the staging tables to hold the raw data received from the external webshop. All incoming data fields must be of type `Text` to prevent API failures during the initial POST request.

### 1.1. Enums
*   **Object:** `Enum 50100 "DEF Webshop Order Status"`
*   **Values:**
    *   `0` = `Pending` (Default)
    *   `1` = `Processed`
    *   `2` = `Error`

### 1.2. Tables
**Folder:** `src/Webshop/Tables/`

#### Table 50100 "DEF Webshop Order Header"
*   **PK:** `Order No.` (Code[20]) - *Note: While external ID is text, we usually map it to a Code field for PK, or use a separate "External Order No." as Text and an auto-incrementing Entry No. Given the requirement "All data fields... must be of type Text", we will use "External Order No." (Text[50]) as the primary identifier for the external system, but internally we might need a cleaner PK or just use the Text field if length allows. Let's stick to the requirement: "Order No" as Text[50] as PK.*
*   **Fields:**
    *   `1` "Order No." (Text[50]) - PK
    *   `10` "Customer No." (Text[50])
    *   `11` "Order Date" (Text[20])
    *   `12` "Requested Delivery Date" (Text[20])
    *   `20` "Status" (Enum "DEF Webshop Order Status")
    *   `21` "Error Message" (Text[2048])
    *   `22` "Created Sales Order No." (Code[20]) - Link to created doc

#### Table 50101 "DEF Webshop Order Line"
*   **PK:** `Order No.` (Text[50]), `Line No.` (Integer)
*   **Fields:**
    *   `1` "Order No." (Text[50]) - FK to Header
    *   `2` "Line No." (Integer)
    *   `10` "Item No." (Text[50])
    *   `11` "Quantity" (Text[20])
    *   `12` "Unit Price" (Text[20])
    *   `13` "Description" (Text[100])

## Phase 2: API Layer (Exposure)

Expose the staging tables via standard Business Central APIs to allow the webshop to push data.

**Folder:** `src/Webshop/API/`

### 2.1. API Pages
*   **Page 50105 "DEF Webshop Order API"**
    *   **Source Table:** "DEF Webshop Order Header"
    *   **PageType:** `API`
    *   **APIPublisher:** `myCompany`
    *   **APIGroup:** `webshop`
    *   **APIVersion:** `v1.0`
    *   **EntityName:** `webshopOrder`
    *   **EntitySetName:** `webshopOrders`
    *   **SubPage:** Link to "DEF Webshop Order Lines API"

*   **Page 50106 "DEF Webshop Order Lines API"**
    *   **Source Table:** "DEF Webshop Order Line"
    *   **PageType:** `API`
    *   **EntityName:** `webshopOrderLine`
    *   **EntitySetName:** `webshopOrderLines`

## Phase 3: User Interface (Management)

Provide an interface for users to review incoming orders, check errors, and manually trigger processing.

**Folder:** `src/Webshop/Pages/`

### 3.1. Pages
*   **Page 50102 "DEF Webshop Order List"**
    *   **Source Table:** "DEF Webshop Order Header"
    *   **Usage:** Overview of all incoming orders.
    *   **Actions:** "Process Selected"

*   **Page 50103 "DEF Webshop Order Card"**
    *   **Source Table:** "DEF Webshop Order Header"
    *   **Usage:** Detailed view and error correction.
    *   **Actions:** "Process"

*   **Page 50104 "DEF Webshop Order Subform"**
    *   **Source Table:** "DEF Webshop Order Line"
    *   **PageType:** `ListPart`
    *   **Usage:** Embedded in the Card page to show lines.

## Phase 4: Business Logic (Processing)

Implement the core logic to validate and transform the staging data into real Business Central documents.

**Folder:** `src/Webshop/Codeunits/`

### 4.1. Processing Codeunit
*   **Codeunit 50107 "DEF Webshop Processing"**
*   **Responsibilities:**
    1.  **Run(Record):** Main entry point.
    2.  **ValidateHeader(Record):** Check if Customer exists, parse dates.
    3.  **ValidateLine(Record):** Check if Item exists, parse decimals (Qty, Price).
    4.  **CreateSalesHeader(Record):** Insert `Sales Header`.
    5.  **CreateSalesLine(Record):** Insert `Sales Line`.
    6.  **Error Handling:** Wrap logic in `TryFunction` or handle return values to catch errors. Update "Status" to `Error` and populate "Error Message" if validation fails. Update "Status" to `Processed` on success.

## Phase 5: Testing Strategy

**Folder:** `apps/MyCoreApp.Test/src/codeunits/`

*   **Codeunit 50108 "DEF Webshop Process Test"**
    *   Test Case 1: Valid data creates a Sales Order.
    *   Test Case 2: Invalid Customer No. sets Status to Error.
    *   Test Case 3: Invalid Date format sets Status to Error.
    *   Test Case 4: Invalid Decimal format in Line sets Status to Error.