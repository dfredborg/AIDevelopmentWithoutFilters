# Project Brief: Webshop Integration

## Overview
This project aims to integrate an external webshop with Microsoft Dynamics 365 Business Central using a robust Staging Pattern. The primary objective is to decouple data reception from business logic validation to ensure 100% successful data ingestion, regardless of data quality at the entry point.

## Core Requirements
1.  **Staging Pattern:** Implement "loose" staging tables with text-based fields to accept raw data without validation errors during ingestion.
2.  **Data Ingestion:** Expose API endpoints for external systems to push order data (Header and Lines) into Business Central.
3.  **Error Handling:** Validation logic must be applied *after* ingestion. Errors should be logged in the staging tables, allowing manual correction via UI without blocking the initial transfer.
4.  **Processing Logic:** A dedicated routine will transform valid staging data into standard Sales Orders.
5.  **User Interface:** Provide Business Central pages for users to view, edit, and retry processing of staging records.

## Success Criteria
*   External webshop can successfully POST order data to Business Central APIs without 400/500 errors due to data validation (e.g., missing customer, wrong data type).
*   Users can view raw data in Business Central.
*   Users can correct data errors (e.g., fix a typo in an email address) and re-process the order.
*   Valid orders are converted to Sales Orders.