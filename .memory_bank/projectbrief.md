# Project Brief: Webshop Integration

## Overview
This project implements a robust integration strategy between an external webshop and Microsoft Dynamics 365 Business Central. The core design philosophy is to decouple data ingestion from business logic validation using a "Staging Pattern." This ensures that external data is always received successfully, even if it contains validation errors, allowing for asynchronous processing and manual correction within Business Central.

## Core Goals
1.  **Decoupled Architecture:** Separate the API data reception from the complex business logic required to create Sales Documents.
2.  **100% Ingestion Success:** Use "loose" staging tables with text-based fields to prevent API failures due to data type mismatches or truncation.
3.  **Graceful Error Handling:** Capture validation errors during the processing phase (not the ingestion phase) and log them for user review.
4.  **User Empowerment:** Provide a UI for users to view raw staging data, see error messages, and make manual corrections before re-processing.

## Key Features
*   **Staging Tables:** `DEF Webshop Header Staging` and `DEF Webshop Line Staging` to hold raw data.
*   **API Endpoints:** Standard CRUD APIs exposing the staging tables to the external webshop.
*   **Processing Logic:** A dedicated Codeunit to validate staging data (e.g., mapping Email to Customer No., SKU to Item No.) and convert it into standard Sales Orders/Quotes.
*   **Status Tracking:** A workflow status on staging records (`Pending`, `Completed`, `Error`) to manage the lifecycle of incoming orders.

## Scope
The project covers the end-to-end flow from API reception to the creation of a Sales Header and Sales Lines. It includes the database structure, user interface, API layer, and business logic for processing.