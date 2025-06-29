
-- 1. Database Setup
-- Database Creation: Created a database named library_db.
Create database library_db;


-- Table Creation:
-- Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15));


-- Create table "Employee"
CREATE TABLE employees(
            emp_id VARCHAR(10) PRIMARY KEY,
            emp_name VARCHAR(30),
            position VARCHAR(30),
            salary DECIMAL(10,2),
            branch_id VARCHAR(10),
            FOREIGN KEY (branch_id) REFERENCES  branch(branch_id));


-- Create table "Members"
CREATE TABLE members(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE);


-- Create table "Books"
CREATE TABLE books(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30));


-- Create table "IssueStatus"
CREATE TABLE issued_status(
            issued_id VARCHAR(10) PRIMARY KEY,
            issued_member_id VARCHAR(30),
            issued_book_name VARCHAR(80),
            issued_date DATE,
            issued_book_isbn VARCHAR(50),
            issued_emp_id VARCHAR(10),
            FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
            FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
            FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn));
            
-- Create table "ReturnStatus"
CREATE TABLE return_status(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn));
            


-- 2. CRUD Operations
-- Create: Inserted sample records into the books table.
-- Read: Retrieved and displayed data from various tables.
-- Update: Updated records in the employees table.
-- Delete: Removed records from the members table as needed.


-- Task 1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
insert into books (isbn, book_title, category, rental_price, status, author, publisher)
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');


-- Task 2: Update an Existing Member's Address
update members
set member_Address = '125 Oak St'
where member_id = 'C103';


-- Task 3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
delete from issued_status 
where issued_id = 'IS121';


-- Task 4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
select * 
from issued_status 
where issued_emp_id = 'E101';


-- Task 5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
select 
	issued_member_id, 
	count(issued_book_name) as ttl_issued_book 
from issued_status
group by issued_member_id 
having count(issued_book_name) >2;


-- Task 6: Create Summary Tables: Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**
create table book_issued_cnt as (
	select 
		b.isbn, 
        b.book_title, 
        count(ist.issued_id) as issued_cnt
	from books b
	join issued_status ist on ist.issued_book_isbn=b.isbn
	group by b.isbn, b.book_title);
select * from book_issued_cnt;


-- 4. Data Analysis & Findings
-- Task 7. Retrieve All Books in a Specific Category:
select * 
from books 
where category = 'classic';


-- Task 8: Find Total Rental Income by Category:
SELECT 
    b.category,
    SUM(b.rental_price),
    COUNT(*)
FROM 
issued_status as ist
JOIN
books as b
ON b.isbn = ist.issued_book_isbn
GROUP BY b.category;


-- 9.List Members Who Registered in the Last 180 Days:
select * 
from members
where reg_date > date_sub(current_date, interval 180 day);


-- List Employees with Their Branch Manager's Name and their branch details:
select
	e.emp_id, e.emp_name, e.position, e.salary, b.*, e2.emp_name as manager_name
from employees e
join branch b on b.branch_id=e.branch_id
join employees e2 on e2.emp_id=b.manager_id;


-- Task 11. Create a Table of Books with Rental Price Above a Certain Threshold:
create table expensive_books as (
select * from books where rental_price > 7.00);
select * from expensive_books;


-- Task 12: Retrieve the List of Books Not Yet Returned
select
	ist.issued_book_name, ist.issued_book_isbn
from issued_status ist
left join return_status rs on rs.issued_id=ist.issued_id
where rs.return_id is null;


-- Advanced SQL Operations
-- Task 13: Identify Members with Overdue Books
-- Write a query to identify members who have overdue books (assume a 30-day return period).
-- Display the member's_id, member's name, book title, issue date, and days overdue.
select
	ist.issued_member_id, m.member_name, b.book_title, ist.issued_date,
    datediff(current_date(), ist.issued_date) as overdue
from issued_status ist
left join return_status rs on rs.issued_id = ist.issued_id
join members m on m.member_id = ist.issued_member_id
join books b on ist.issued_book_isbn = b.isbn
where rs.return_id is null and
datediff(current_date(), ist.issued_date) > 30;


-- Task 14: Update Book Status on Return
-- Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).
DELIMITER $$


CREATE PROCEDURE update_book_status_based_on_return()
BEGIN
    -- First set all books to 'Pending'
    UPDATE books
    SET status = 'Pending';


    -- Then update books to 'Yes' if their issued_id is in return_status
    UPDATE books b
    JOIN issued_status i ON b.isbn = i.issued_book_isbn
    JOIN return_status r ON i.issued_id = r.issued_id
    SET b.status = 'Yes';
END$$


DELIMITER ;


CALL update_book_status_based_on_return();


-- Task 15: Branch Performance Report
-- Create a query that generates a performance report for each branch, showing the number of books issued,
-- the number of books returned, and the total revenue generated from book rentals.
create table branch_reports as (
select
	br.branch_id, br.manager_ID, br.branch_address,
    count(ist.issued_ID) as issued_cnt,
    count(rs.return_ID) as return_cnt,
    sum(bk.rental_price) as total_revenue
from branch br
join employees e using (branch_id)
join issued_status ist on ist.issued_emp_id=e.emp_id
join books bk on bk.isbn=ist.issued_book_isbn
left join return_status rs on bk.isbn=rs.return_book_isbn
group by br.branch_id, br.manager_id, br.branch_address);


select * from branch_reports;


-- Task 16: CTAS: Create a Table of Active Members
-- Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members
-- who have issued at least one book in the last 2 months.


CREATE TABLE active_members AS
SELECT * FROM members
WHERE member_id IN (SELECT
                        DISTINCT issued_member_id   
                    FROM issued_status
                    WHERE 
                        issued_date >= date_sub(CURRENT_DATE, INTERVAL 2 month)
                    );
SELECT * FROM active_members;


-- Task 17: Find Employees with the Most Book Issues Processed
-- Write a query to find the top 3 employees who have processed the most book issues.
-- Display the employee name, number of books processed, and their branch.
select
	emp_name, b.*,
    count(issued_id) as total_issued_books
from employees e
join issued_status ist on ist.issued_emp_id=e.emp_id
join branch b using(branch_id)
group by 1,2
order by total_issued_books desc
limit 3;


-- Task 18: Identify Members Issuing High-Risk Books
-- Write a query to identify members who have issued books more than twice with the status "damaged" in the books table.
-- Display the member name, book title, and the number of times they've issued damaged books.
select
	member_name, book_title,
    count(issued_id) as damage_issued_book_cnt
from members m
join issued_status ist on ist.issued_member_id=m.member_id
join books bk on bk.isbn=ist.issued_book_isbn and bk.status='damaged'
group by 1,2
having damage_issued_book_cnt > 2
order by 3;


-- Task 19: Stored Procedure Objective: Create a stored procedure to manage the status of books in a library system.
-- Description: Write a stored procedure that updates the status of a book in the library based on its issuance.
-- The procedure should function as follows: The stored procedure should take the book_id as an input parameter.
-- The procedure should first check if the book is available (status = 'yes'). \
-- If the book is available, it should be issued, and the status in the books table should be updated to 'no'.
-- If the book is not available (status = 'no'), the procedure should return an error message indicating that
-- the book is currently not available.


-- Change delimiter to allow compound statements
DELIMITER $$


CREATE PROCEDURE issue_book (
    IN p_issued_id VARCHAR(10),
    IN p_issued_member_id VARCHAR(30),
    IN p_issued_book_isbn VARCHAR(30),
    IN p_issued_emp_id VARCHAR(10)
)
BEGIN
    DECLARE v_status VARCHAR(10);


    -- Check if the book is available
    SELECT status INTO v_status
    FROM books
    WHERE isbn = p_issued_book_isbn;


    IF v_status = 'yes' THEN
        -- Insert issue record
        INSERT INTO issued_status (
            issued_id,
            issued_member_id,
            issued_date,
            issued_book_isbn,
            issued_emp_id
        )
        VALUES (
            p_issued_id,
            p_issued_member_id,
            CURRENT_DATE,
            p_issued_book_isbn,
            p_issued_emp_id
        );


        -- Update book status to 'no'
        UPDATE books
        SET status = 'no'
        WHERE isbn = p_issued_book_isbn;


        -- Success message
        SELECT CONCAT('Book issued successfully. ISBN: ', p_issued_book_isbn) AS message;


    ELSE
        -- Book not available
        SELECT CONCAT('Book is unavailable. ISBN: ', p_issued_book_isbn) AS message;
    END IF;
END$$


-- Call the procedure
CALL issue_book('IS155', 'C108', '978-0-553-29698-2', 'E104');
CALL issue_book('IS156', 'C108', '978-0-375-41398-8', 'E104');


-- View data
SELECT * FROM books;
SELECT * FROM issued_status;










-- Task 20: Create Table As Select (CTAS) Objective: Create a CTAS (Create Table As Select) query to identify overdue books and calculate fines.
-- Description: Write a CTAS query to create a new table that lists each member and the books they have issued but not returned within 30 days.
-- The table should include: The number of overdue books. The total fines, with each day's fine calculated at $0.50.
-- The number of books issued by each member. The resulting table should show: Member ID Number of overdue books Total fines


create table member_wise_fine
AS
select
	member_id,
    count(issued_id) as issued_book_cnt,
    count(case when return_ID is null and CURDATE() > date_add(issued_Date, interval 30 day) then 1 end) as overdue_book_cnt,
    sum(case when return_id is null 
			and CURDATE() > date_add(issued_Date, interval 30 day)
            then round(datediff(curdate(),date_Add(issued_date, interval 30 day))*0.50,2) end) as overdue_fines
from (
select
	m.member_id, ist.issued_id, issued_date, rs.return_id, rs.return_date
from members m
join issued_status ist on ist.issued_member_id=m.member_id
left join return_status rs on rs.issued_id=ist.issued_id
	) a
group by member_id
order by overdue_fines;
select * from member_wise_fine;
