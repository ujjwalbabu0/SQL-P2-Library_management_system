# SQL-P2-Library_management_system
- **Author - Ujjwal Babu**

# 📚 Library System Management

Welcome to the **Library Management System project** — an intermediate-level SQL portfolio project designed to demonstrate ability to work with relational databases. This project highlights how to design, manage, and query a library database using SQL, simulating real-world operations like issuing and returning books.

![Uploading Library.PNG…]()


---

## Project Overview

- **Level:** Intermediate & Advance
- **Database:** `Library_db`
- **Skills Covered:** SQL, Database Design, CRUD Operations, Joins, Subqueries, Stored Procedures, Data Manipulation

---


## Objectives
- 1.**Database Setup:** Design and populate the library_db with essential tables including:
    `branches`, `employees`, `members`, `books`, `issue_status`, `return_status`
- 2.**CRUD Operations:** Execute Create, Read, Update, and Delete operations to manage library data effectively.
- 3.**CTAS (Create Table As Select):** Use CTAS to generate new tables derived from existing query results, aiding in reporting and analysis.
- 4.**Advanced SQL Queries:** Write complex SQL queries involving joins, filters, subqueries, and aggregations to extract actionable insights from the database.

---

##  Project Structure

### 1.Database_setup

![library_erd](https://github.com/user-attachments/assets/ae3270ff-4f13-49bb-ab39-9a158c49ac14)

- **Database Creation;**
A relational database named `library_db` was created to simulate a library environment.

- **Table Creation:**
Tables were designed to represent key entities and their relationships, including:

- `branches` – Stores information about library locations
- `employees` – Details about staff assigned to branches
- `members` – Information on registered library users
- `books` – Catalog of available books with ISBN and status
- `issue_status` – Tracks which books have been issued, when, and to whom
- `return_status` – Logs details of returned books to track availability


## Key Business Questions

# 2.CRUD Operations
- **Create:** Inserted sample records into the `books` table.
- **Read:** Retrieved and displayed data from `various` tables.
- **Update:** Updated records in the `employees` table.
- **Delete:** Removed records from the `members` table as needed.---

1. **Create a New Book Record** -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
2. **Update an Existing Member's Address**
3. **Delete a Record from the Issued Status Table** -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
4. **Retrieve All Books Issued by a Specific Employee** -- Objective: Select all books issued by the employee with emp_id = 'E101'.
5. **List Members Who Have Issued More Than One Book** -- Objective: Use GROUP BY to find members who have issued more than one book.

# 3.CTAS- Create Table as Select
7. **Create Summary Tables:** Used CTAS to generate new tables based on query results - each book and total book_issued_cnt.

# 4.Data Analysis & Findings
8. **Retrieve All Books in a Specific Category:**
9. **List Members Who Registered in the Last 180 Days:**
10. **List Employees with Their Branch Manager's Name and their branch details:**
11. **Create a Table of Books with Rental Price Above a Certain Threshold:**
12. **Retrieve the List of Books Not Yet Returned**

# 5.Advanced SQL Operations
13. **Identify Members with Overdue Books:**
Write a query to identify members who have overdue books (assume a 30-day return period). Display the member's_id, member's name, book title, issue date, and days overdue.
14. **Update Book Status on Return:**
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
15. **Branch Performance Report:**
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.
16. **CTAS: Create a Table of Active Members:**
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
17. **Find Employees with the Most Book Issues Processed:**
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.
18. **Identify Members Issuing High-Risk Books:**
Write a query to identify members who have issued books more than twice with the status "damaged" in the books table. Display the member name, book title, and the number of times they've issued damaged books.
19. **Stored Procedure Objective:**
Create a stored procedure to manage the status of books in a library system. Description: Write a stored procedure that updates the status of a book in the library based on its issuance. The procedure should function as follows: The stored procedure should take the book_id as an input parameter. The procedure should first check if the book is available (status = 'yes'). If the book is available, it should be issued, and the status in the books table should be updated to 'no'. If the book is not available (status = 'no'), the procedure should return an error message indicating that the book is currently not available.
20. **Create Table As Select (CTAS) Objective:**
Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.
Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days. The table should include: The number of overdue books. The total fines, with each day's fine calculated at $0.50. The number of books issued by each member. The resulting table should show: Member ID Number of overdue books Total fines

### Reports
- **Database Schema:** Clear structure of tables and relationships.
- **Data Analysis:** Insights on book demand, employee salaries, member trends, and issue history.
- **Summary Reports:** Aggregated data on top books and staff performance.


### Conclusion
- This project showcases the practical application of SQL in building and managing a Library Management System. It covers database design, data manipulation, and advanced querying, providing a strong foundation in relational database management and analytical thinking.

### The Repository

```bash
https://github.com/ujjwalbabu0/SQL-P2-Library_management_system
