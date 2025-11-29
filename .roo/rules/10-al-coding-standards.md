# AL Coding Standards

## 1. File Naming Patterns
Files must be named using the pattern: `[Prefix][ObjectName].[ObjectType].al`.
*Note: Remove spaces from the object name in the filename.*

| Object Type | Naming Pattern | Example |
| :--- | :--- | :--- |
| Table | `DEF[Name].Table.al` | `DEFSalesSetup.Table.al` |
| Page | `DEF[Name].Page.al` | `DEFSalesSetup.Page.al` |
| Codeunit | `DEF[Name].Codeunit.al` | `DEFSalesLogic.Codeunit.al` |
| Table Extension | `DEF[Name].TableExt.al` | `DEFSalesHeader.TableExt.al` |
| Page Extension | `DEF[Name].PageExt.al` | `DEFSalesOrder.PageExt.al` |
| Enum | `DEF[Name].Enum.al` | `DEFStatus.Enum.al` |

## 2. Mandatory Properties
- **ApplicationArea:** Must be set to `#All` for all visible Page Fields and Actions.
- **Tooltips:** MANDATORY for all Page Fields and Actions.
  - *Format:* "Specifies the [Field Name] which is used for [Purpose]."
- **DataClassification:** Must be set on all Table Fields (Default: `CustomerContent`).
- **Captions:** Do not leave `Caption` empty.

## 3. Syntax Rules
- **No Implicit With:** Always use explicit variable referencing (e.g., `Rec.Field` instead of `Field`).
- **Enums:** Always use `Enum` objects instead of `Option` fields.
