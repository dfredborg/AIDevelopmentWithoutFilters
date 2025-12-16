# Phase 4: Webshop Order Processing Design

## Overview
This phase implements the core logic to convert staged Webshop orders into Business Central Sales Orders. The process involves validating the staged data (Customer and Item existence) and creating the corresponding Sales documents.

## Objects
*   **Codeunit 50107:** `DEF Webshop Processing`

## Logic Flow

### 1. Main Entry Point: `ProcessOrder`
*   **Purpose:** Orchestrates the process and handles transaction safety.
*   **Input:** `var WebshopHeader: Record "DEF Webshop Header Staging TDY"`
*   **Logic:**
    *   Uses `Codeunit.Run` to execute the actual creation logic (`CreateSalesOrder`) in an isolated transaction.
    *   **On Success:**
        *   Sets `WebshopHeader.Status` = `Completed`.
        *   Sets `WebshopHeader."Error Message"` = ''.
    *   **On Failure:**
        *   Sets `WebshopHeader.Status` = `Error`.
        *   Sets `WebshopHeader."Error Message"` = `GetLastErrorText()`.
    *   **Persistence:** The status update is performed on the `WebshopHeader` record passed by VAR. The caller is responsible for modifying/committing the header update, or the Codeunit can modify it directly if it's not a temporary record. *Decision:* The Codeunit will `Modify` the header record to persist the status.

### 2. Business Logic: `CreateSalesOrder` (Internal)
*   **Purpose:** Performs the actual validation and creation.
*   **Input:** `WebshopHeader: Record "DEF Webshop Header Staging TDY"`
*   **Steps:**
    1.  **Identify Customer:**
        *   Call `GetCustomerNo(WebshopHeader."Customer Email")`.
        *   If empty, Error: "Customer with email %1 not found."
    2.  **Create Sales Header:**
        *   Initialize `Sales Header`.
        *   `Document Type` := `Order`.
        *   `No.` := '' (Trigger standard No. Series).
        *   `Insert(true)`.
        *   `Validate("Sell-to Customer No.", CustomerNo)`.
        *   `Validate("External Document No.", WebshopHeader."Webshop Order No.")`.
        *   `Validate("Order Date", ParseDate(WebshopHeader."Order Date"))`.
        *   `Modify(true)`.
    3.  **Process Lines:**
        *   Filter `DEF Webshop Line Staging TDY` by `Webshop Order No.`.
        *   Iterate through lines.
    4.  **Create Sales Line:**
        *   **Identify Item:**
            *   Call `GetItemNo(StagingLine."Product SKU")`.
            *   If empty, Error: "Item with SKU %1 not found."
        *   Initialize `Sales Line`.
        *   `Document Type` := `Order`.
        *   `Document No.` := `SalesHeader."No."`.
        *   `Line No.` := `StagingLine."Line No."`.
        *   `Insert(true)`.
        *   `Validate(Type, Type::Item)`.
        *   `Validate("No.", ItemNo)`.
        *   `Validate(Quantity, ParseDecimal(StagingLine.Quantity))`.
        *   `Validate("Unit Price", ParseDecimal(StagingLine."Unit Price"))`.
        *   `Modify(true)`.

### 3. Helper Procedures
*   `local procedure GetCustomerNo(Email: Text): Code[20]`
    *   Search `Customer` table (Key: `E-Mail`).
    *   Return `No.` if found, else empty.
*   `local procedure GetItemNo(SKU: Text): Code[20]`
    *   Search `Item` table (Key: `No.`). *Assumption: SKU matches Item No.*
    *   Return `No.` if found, else empty.
*   `local procedure ParseDecimal(Value: Text): Decimal`
    *   Use `Evaluate` to convert Text to Decimal.
    *   Handle potential format errors (though `Evaluate` returns false, we might want to error out if invalid).
*   `local procedure ParseDate(Value: Text): Date`
    *   Use `Evaluate` to convert Text to Date (ISO format expected).

## Error Handling Strategy
*   **Isolation:** The creation logic runs in a separate transaction scope (via `Codeunit.Run` or a separate Codeunit instance if needed, but `Codeunit.Run` on a separate ID or self is standard). Since we are inside the same codeunit, we might need a separate "Worker" codeunit or structure the `ProcessOrder` to call a local procedure wrapped in a `TryFunction` is not recommended for database writes.
*   **Refined Strategy:**
    *   `ProcessOrder` calls `Codeunit.Run(Codeunit::"DEF Webshop Order Worker", WebshopHeader)`.
    *   We need a **Worker Codeunit** (or we structure `DEF Webshop Processing` to handle the run logic itself if it's the runner).
    *   *Simplification:* `DEF Webshop Processing` will contain the logic. The *caller* (e.g., a Job Queue or Action) should handle the `If Codeunit.Run...` pattern.
    *   *Correction based on Requirements:* The requirement says "If any error occurs... catch it... Update Staging Header". This implies `DEF Webshop Processing` should handle the try/catch internally so the caller just calls `ProcessOrder`.
    *   **Implementation:** `ProcessOrder` will use a `TryFunction` for the creation logic? **No**, `TryFunction` cannot handle database write transactions properly if we want to roll back.
    *   **Best Practice:** `ProcessOrder` calls a separate Codeunit (e.g., itself, if structured correctly, or a helper) to do the work.
    *   **Design Decision:** We will split the logic.
        *   `DEF Webshop Processing` (50107): The Controller.
        *   `DEF Webshop Order Worker` (50108 - *New proposed ID*): The Worker.
    *   *Alternative:* Keep it in one Codeunit (50107). `ProcessOrder` calls `CreateSalesOrder`. `CreateSalesOrder` is the logic. The *Caller* (e.g. the Page Action) does `if not WebshopProcessing.Run(Header) then ...`.
    *   *Requirement Check:* "Codeunit Name: DEF Webshop Processing (ID 50107)".
    *   *Revised Design:* `DEF Webshop Processing` (50107) is the **Worker**. It has the `OnRun` trigger or a main function that does the work and errors out if it fails.
    *   We will add a **Wrapper/Controller** logic in the *Page Action* or *Job Queue* to catch the error.
    *   *Wait*, the requirement says: "Update Staging Header Status to Error... Do NOT stop the process for other orders".
    *   If 50107 is the processor for a *single* order, then the *Caller* (looping through records) is responsible for the Try/Catch pattern.
    *   **However**, to make 50107 self-contained as requested ("Error Handling... catch it... Update Staging Header"), 50107 should probably expose a `Process(var Header)` procedure that handles the error internally.
    *   **Solution:** `DEF Webshop Processing` will have a `TryFunction` helper `TryCreateOrder`.
        *   `ProcessOrder` calls `if TryCreateOrder(...) then Success else Failure`.
        *   *Note:* `TryFunction` changes to the database are NOT rolled back automatically if the error is thrown *after* the write. This is risky for partial orders.
    *   **Safe Solution:** Use `Codeunit.Run`.
        *   We need a separate ID for the "Worker" to run it safely.
        *   Since we are limited to assigned IDs, and 50107 is the "Processing" codeunit, let's assume 50107 is the **Worker** (doing the job).
        *   We will create a `Process` procedure in 50107 that does the work.
        *   The *Caller* (e.g., a Page Action) will do:
            ```al
            if Codeunit.Run(Codeunit::"DEF Webshop Processing", Header) then begin
                Header.Status := Completed;
                Header.Modify();
            end else begin
                Header.Status := Error;
                Header."Error Message" := GetLastErrorText();
                Header.Modify();
            end;
            Commit(); // Commit per order
            ```
    *   **Design Update:** The TDD will specify that Codeunit 50107 contains the *business logic* to create the order. It will throw an error if validation fails. The *Caller* is responsible for the `Codeunit.Run` wrapper to handle the status update, OR 50107 provides a "SafeProcess" procedure that calls itself via `Codeunit.Run`. Let's go with the latter for encapsulation.
    *   **Encapsulated Pattern:**
        *   `Codeunit 50107` has `OnRun(Rec)` -> Calls `CreateOrder(Rec)`.
        *   `Codeunit 50107` has `Process(var Header)` -> Calls `Codeunit.Run(Codeunit::"DEF Webshop Processing", Header)`. Updates Status based on result.

## Test Plan

### Unit Test Codeunit: `DEF Webshop Processing Test`

#### Scenarios
1.  **Success Path:**
    *   **Setup:** Create Staging Header (Status=Pending), Staging Line. Create Customer (Email match). Create Item (SKU match).
    *   **Action:** Call `ProcessOrder`.
    *   **Verification:**
        *   Staging Header Status = Completed.
        *   Sales Header exists (Order, Ext Doc No match).
        *   Sales Line exists (Item, Qty, Price match).

2.  **Validation Failure - Customer:**
    *   **Setup:** Staging Header with non-existent email.
    *   **Action:** Call `ProcessOrder`.
    *   **Verification:**
        *   Staging Header Status = Error.
        *   Error Message contains "Customer".
        *   No Sales Header created.

3.  **Validation Failure - Item:**
    *   **Setup:** Valid Customer, Staging Line with non-existent SKU.
    *   **Action:** Call `ProcessOrder`.
    *   **Verification:**
        *   Staging Header Status = Error.
        *   Error Message contains "Item".
        *   Sales Header NOT created (Rolled back).

4.  **Data Failure - Invalid Quantity:**
    *   **Setup:** Staging Line with Quantity = "ABC".
    *   **Action:** Call `ProcessOrder`.
    *   **Verification:**
        *   Staging Header Status = Error.
        *   Error Message contains conversion error.