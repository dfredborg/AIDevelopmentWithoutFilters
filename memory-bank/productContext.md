# Product Context

## Project Name
MyCoreApp (Webshop Integration)

## Goals
The primary goal of this project is to implement a robust, fault-tolerant Webshop Integration for Microsoft Dynamics 365 Business Central.

## Problem Statement
Directly pushing typed data (Integers, Decimals, Dates) from external webshops into Business Central APIs often leads to failures if the format doesn't match exactly. This creates a fragile integration where orders are lost or rejected due to minor formatting issues.

## Core Functionality
1.  **Staging Layer:** Receive all external data as `Text` into intermediate "Staging Tables". This ensures the API call from the webshop almost always succeeds.
2.  **Validation & Transformation:** Process the text data asynchronously or on-demand within Business Central. Validate customer existence, item availability, and parse text into correct data types (Dates, Decimals).
3.  **Error Handling:** Capture validation errors in the staging table without rejecting the initial API request. Allow users to view and correct errors directly in BC.
4.  **Document Creation:** Convert valid staging records into standard Business Central Sales Orders.

## Scope
*   **In Scope:**
    *   Staging Tables for Order Headers and Lines.
    *   API Pages for external access.
    *   UI Pages for internal management (List, Card, Subform).
    *   Processing Logic (Codeunit) for validation and conversion.
    *   Unit Tests.
*   **Out of Scope:**
    *   Modifications to the external webshop itself.
    *   Inventory synchronization (currently focused on Order Import).