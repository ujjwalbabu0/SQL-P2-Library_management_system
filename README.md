![library_erd](https://github.com/user-attachments/assets/ae3270ff-4f13-49bb-ab39-9a158c49ac14)# SQL-P2-Library_management_system
**Author - Ujjwal Babu**

# 📚 Library System Management

Welcome to the **Library Management System project** — an intermediate-level SQL portfolio project designed to demonstrate ability to work with relational databases. This project highlights how to design, manage, and query a library database using SQL, simulating real-world operations like issuing and returning books.

---

## Project Overview

- **Level:** Intermediate
- **Database:** `Library_db`
- **Skills Covered:** SQL, Database Design, CRUD Operations, Joins, Subqueries, Stored Procedures, Data Manipulation

---


## Objectives
1.**Database Setup:** Design and populate the library_db with essential tables including:
`branches`, `employees`, `members`, `books`, `issue_status`, `return_status`
2.**CRUD Operations:** Execute Create, Read, Update, and Delete operations to manage library data effectively.
3.**CTAS (Create Table As Select):** Use CTAS to generate new tables derived from existing query results, aiding in reporting and analysis.
4.**Advanced SQL Queries:** Write complex SQL queries involving joins, filters, subqueries, and aggregations to extract actionable insights from the database.

---

##  Project Structure

### 1. database_setup


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


### 2. cleaning_queries
- Check for NULLs
- Delete invalid rows
- Explore distinct values

### 3. analysis_queries
- Total sales by category
- Top customers
- Sales trends by month and shift

### 4. reports/sales_summary
Contains findings and observations based on the SQL analysis.

---

## Key Business Questions

- Q.1 Retrieve all columns for sales made on '2022-11-05'
- Q.2 Retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of November 2022
- Q.3 Calculate the total sales (total_sale) for each category
- Q.4 Find the average age of customers who purchased items from the 'Beauty' category
- Q.5 Find all transactions where the total sale is greater than 1000
- Q.6 Find the total number of transactions (transaction_id) made by each gender in each category
- Q.7 Calculate the average sale for each month. Find out the best-selling month in each year
- Q.8 Find the top 5 customers based on the highest total sales
- Q.9 Find the number of unique customers who purchased items from each category
- Q.10 Create each shift and the corresponding number of orders (Example: Morning <=12, Afternoon Between 12 & 17, Evening >17)


### The Repository

```bash
https://github.com/ujjwalbabu0/SQL_P1---Retail_sales_analysis
