# Task 6: Subqueries and Nested Queries – Library Database

## ✨ Objective
To demonstrate the use of scalar, correlated, and nested subqueries in SELECT, WHERE, and FROM clauses using a relational library database.

## 📂 Database Structure
The `library_database.sql` includes:
- `books`: Books with author and category references.
- `authors`: Book authors.
- `categories`: Genre classification.
- `members`: Library users.
- `loans`: Book lending transactions.
- `staff`: Staff handling the loans.

## 🔢 SQL Subquery Examples

### 1. Scalar Subquery
Get book titles with number of times each has been loaned.
```sql
SELECT title,
       (SELECT COUNT(*) FROM loans WHERE loans.book_id = books.book_id) AS total_loans
FROM books;
```

### 2. Subquery with IN
Get members who have borrowed books.
```sql
SELECT name FROM members
WHERE member_id IN (SELECT member_id FROM loans);
```

### 3. Subquery with EXISTS
List authors whose books have been loaned.
```sql
SELECT name FROM authors
WHERE EXISTS (
  SELECT 1 FROM books
  JOIN loans ON books.book_id = loans.book_id
  WHERE books.author_id = authors.author_id
);
```

### 4. Correlated Subquery
Find books with above-average number of loans.
```sql
SELECT title FROM books
WHERE (SELECT COUNT(*) FROM loans WHERE loans.book_id = books.book_id) > (
  SELECT AVG(cnt) FROM (
    SELECT COUNT(*) AS cnt FROM loans GROUP BY book_id
  ) AS avg_loans
);
```

### 5. Subquery in FROM (Derived Table)
Display member names with number of loans.
```sql
SELECT m.name, loan_data.total_loans
FROM members m
JOIN (
  SELECT member_id, COUNT(*) AS total_loans
  FROM loans
  GROUP BY member_id
) AS loan_data ON m.member_id = loan_data.member_id;
```

### 6. NOT EXISTS
List members who never borrowed any book.
```sql
SELECT name FROM members
WHERE NOT EXISTS (
  SELECT 1 FROM loans WHERE loans.member_id = members.member_id
);
```

### 7. Nested Subquery with MAX
Find the book loaned most frequently.
```sql
SELECT title FROM books
WHERE book_id = (
  SELECT book_id FROM (
    SELECT book_id, COUNT(*) AS cnt FROM loans GROUP BY book_id ORDER BY cnt DESC LIMIT 1
  ) AS top_book
);
```

### 8. Subquery with =
Get category name of the oldest published book.
```sql
SELECT name FROM categories
WHERE category_id = (
  SELECT category_id FROM books ORDER BY publication_year ASC LIMIT 1
);
```

## 📈 Output Highlights
- Scalar subqueries return single values used in SELECT.
- `EXISTS`/`NOT EXISTS` provide logical filters.
- Correlated subqueries use outer table reference.
- Subqueries in FROM act as derived tables.

## 📁 Files Included
- `library_database.sql` – Data schema
- `Sql_Subqueries_Task6.sql` – Subquery implementations
- `README.md` – This file

## 🚀 Tools Used
- MySQL Workbench
- SQLite (Optional)

## 🔹 Key Concepts
- Scalar and Correlated Subqueries
- Filtering with `IN`, `EXISTS`, `NOT EXISTS`
- Subquery in SELECT, WHERE, FROM
- Derived Tables

## 📥 Submission
1. Upload project files to a GitHub repository
2. Submit the repo link at: [Submission Link](https://forms.gle/8Gm83s53KbyXs3Ne9)

---
> Prepared for SQL Developer Internship – Task 6: Subqueries Practice

