# Singleton Design Pattern

## 1. Core Concept
- **Rule:** Use the Singleton pattern to ensure only one instance of a class/object exists when appropriate.
- **Goal:** Prevent multiple instances that could lead to inconsistent state or unnecessary resource usage.
- **Application:** Primarily applies to Setup Tables and SingleInstance Codeunits in AL.

## 2. Implementation in AL

### Setup Tables (Natural Singletons)
- **Pattern:** Setup tables typically have one record with a primary key of `''` (empty string).
- **Example:**
  ```al
  table 50100 "DEF Sales Setup"
  {
      DataClassification = CustomerContent;
      
      fields
      {
          field(1; "Primary Key"; Code[10])
          {
              DataClassification = SystemMetadata;
          }
          field(10; "Default Payment Terms"; Code[20])
          {
              DataClassification = CustomerContent;
          }
      }
      
      keys
      {
          key(PK; "Primary Key") { Clustered = true; }
      }
  }
  ```

### SingleInstance Codeunits
- **Pattern:** Use `SingleInstance = true` property for codeunits that should maintain state across calls.
- **Use Cases:**
  - Caching lookup data during a transaction
  - Tracking state during batch operations
  - Event handlers that need to accumulate data

- **Example:**
  ```al
  codeunit 50101 "DEF Cache Manager"
  {
      SingleInstance = true;
      
      var
          CachedValues: Dictionary of [Code[20], Decimal];
      
      procedure GetCachedValue(Key: Code[20]): Decimal
      begin
          if CachedValues.ContainsKey(Key) then
              exit(CachedValues.Get(Key));
          exit(0);
      end;
      
      procedure SetCachedValue(Key: Code[20]; Value: Decimal)
      begin
          if CachedValues.ContainsKey(Key) then
              CachedValues.Set(Key, Value)
          else
              CachedValues.Add(Key, Value);
      end;
  }
  ```

## 3. When to Use Singleton Pattern

### ✅ Appropriate Use Cases
- **Setup Tables:** One configuration record per company.
- **Caching:** Store frequently accessed data during a session.
- **State Management:** Track process state during batch operations.
- **Event Accumulation:** Collect events during a transaction for later processing.

### ❌ Inappropriate Use Cases
- **Transaction Data:** Never use SingleInstance for actual business transactions.
- **Multi-User State:** Do not rely on SingleInstance for cross-user state (it's per session).
- **Database Operations:** Do not use as a replacement for proper database queries.

## 4. Best Practices
- **Setup Tables:** Always implement a `Get()` procedure that retrieves or initializes the single record.
- **SingleInstance Codeunits:** Document the lifetime and scope of cached data clearly.
- **Thread Safety:** Remember that in AL, SingleInstance is per session, not per server.
- **Clear State:** Provide methods to clear cached data when appropriate.

## 5. Example: Setup Table Access Pattern
```al
codeunit 50102 "DEF Sales Setup Mgt"
{
    procedure GetSetup(): Record "DEF Sales Setup"
    var
        SalesSetup: Record "DEF Sales Setup";
    begin
        if not SalesSetup.Get() then begin
            SalesSetup.Init();
            SalesSetup.Insert();
        end;
        exit(SalesSetup);
    end;
}