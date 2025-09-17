# PostgreSQL Stored Procedure Example

This project shows how to use a stored procedure in PostgreSQL with two tables:  
- `cars` → stores existing cars (duplicates allowed)  
- `newcars` → stores cars not found in `cars`  

### Procedure
```sql
CALL InsertCarWithCheck('tata','xuv',2023);
