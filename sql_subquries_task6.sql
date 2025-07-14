-- Task 6: Subqueries and Nested Queries for Library Database

-- 1. Scalar Subquery: Get title and total number of loans per book
SELECT title,
       (SELECT COUNT(*) FROM loans WHERE loans.book_id = books.book_id) AS total_loans
FROM books;

-- 2. Subquery with IN: Find members who have borrowed any book
SELECT name FROM members
WHERE member_id IN (SELECT member_id FROM loans);

-- 3. Subquery with EXISTS: List authors who have at least one book loaned
SELECT name FROM authors
WHERE EXISTS (
  SELECT 1 FROM books
  JOIN loans ON books.book_id = loans.book_id
  WHERE books.author_id = authors.author_id
);

-- 4. Correlated Subquery: List all books that have more loans than the average
SELECT title FROM books
WHERE (SELECT COUNT(*) FROM loans WHERE loans.book_id = books.book_id) > (
  SELECT AVG(cnt) FROM (
    SELECT COUNT(*) AS cnt FROM loans GROUP BY book_id
  ) AS avg_loans
);

-- 5. Subquery in FROM Clause (Derived Table): Show members with number of loans
SELECT m.name, loan_data.total_loans
FROM members m
JOIN (
  SELECT member_id, COUNT(*) AS total_loans
  FROM loans
  GROUP BY member_id
) AS loan_data ON m.member_id = loan_data.member_id;

-- 6. Subquery with NOT EXISTS: Show members who never borrowed a book
SELECT name FROM members
WHERE NOT EXISTS (
  SELECT 1 FROM loans WHERE loans.member_id = members.member_id
);

-- 7. Nested Subquery with MAX: Get the book with highest number of loans
SELECT title FROM books
WHERE book_id = (
  SELECT book_id FROM (
    SELECT book_id, COUNT(*) AS cnt FROM loans GROUP BY book_id ORDER BY cnt DESC LIMIT 1
  ) AS top_book
);

-- 8. Subquery with = : Get category name for the oldest book
SELECT name FROM categories
WHERE category_id = (
  SELECT category_id FROM books ORDER BY publication_year ASC LIMIT 1
);
