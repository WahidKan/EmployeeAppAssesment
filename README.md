# Employee Task Tracker

This is a web application developed with **ASP.NET MVC Web Forms** and **SQL Server** to manage employees and their tasks. It allows creating employee records, listing employees, and assigning tasks dynamically.

---

## Objective

The main objective of this app is to **store, manage, and evaluate employee information and their tasks** efficiently.  
The database is designed to handle:

- Employee records (personal details, date of birth, address)
- Employee tasks with due dates and descriptions
- Efficient CRUD operations through stored procedures and business layer abstraction

---

## Database Design

# Key Features
- Transaction-safe task management
- Batch operations support
- Error handling

# Stored Procedure

```sql
ALTER PROCEDURE [dbo].[SaveEmployeeTasks]
(
    @EmployeeId INT,
    @Tasks dbo.EmployeeTaskType READONLY
)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO EmployeeTask
        (
            EmployeeId,
            Name,
            Description,
            DueDate
        )
        SELECT
            @EmployeeId,
            Name,
            Description,
            DueDate
        FROM @Tasks;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END;
 

### Tables

1. **Employee**

| Field      | Type       | Description               | Validation (UI)                     |
|------------|------------|---------------------------|------------------------------------|
| EmployeeId | int        | Primary Key               | Auto-increment                      |
| Name       | varchar(50)| Name of Employee          | Length 3-30                         |
| DOB        | datetime   | Date of Birth             | Valid datetime before 2000          |
| Address    | varchar(150)| Address                  | Optional                             |

2. **EmployeeTask**

| Field      | Type       | Description               | Validation (UI)                     |
|------------|------------|---------------------------|------------------------------------|
| TaskId     | int        | Primary Key               | Auto-increment                      |
| EmployeeId | int        | Foreign Key (Employee)    | Must exist in Employee table        |
| Name       | varchar(50)| Name of Task              | Length 3-50                         |
| Description| varchar(150)| Task Description         | Optional                             |
| DueDate    | datetime   | Due Date of Task          | Must be after 1st October 2021      |

---

## Business Layer (C# Class Library)

The app uses a separate **Business Layer** to handle logical operations:

| Method            | Type   | Description                       |
|------------------|--------|-----------------------------------|
| SaveEmployee      | CREATE | Save employee data to database     |
| GetEmployees      | READ   | Retrieve all saved employee data   |
| SaveTaskByEmployee| CREATE | Save tasks for an employee         |

---

## Prerequisites

- Visual Studio 2022
- SQL Server (any recent version)
- .NET Framework compatible with Web Forms project

---


