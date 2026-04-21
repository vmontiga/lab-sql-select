-- Challenge 1
SELECT a.au_id AS AUTHOR_ID, a.au_lname AS LAST_NAME, a.au_fname FIRST_NAME, t.title as TITLE, p.pub_name as PUBLISHER
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
LEFT JOIN publishers p ON t.pub_id = p.pub_id
WHERE t.title IS NOT NULL					-- Remove the authors without any published books
ORDER BY a.au_id ASC
--LIMIT 10
;

-- Challenge 2
SELECT a.au_id AS AUTHOR_ID, a.au_lname AS LAST_NAME, a.au_fname FIRST_NAME, p.pub_name as PUBLISHER, COUNT(t.title) AS TITLE_COUNT
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN titles t ON ta.title_id = t.title_id
LEFT JOIN publishers p ON t.pub_id = p.pub_id
WHERE t.title IS NOT NULL					-- Remove the authors without any published books
GROUP BY a.au_id, p.pub_id					
ORDER BY TITLE_COUNT DESC
--LIMIT 10
;
-- We get 24 rows as a result instead of the 25 expected in titleauthor. The difference is because the first rows has a value of 2 hence will be seen as 2 rows in titleauthor.

-- Challenge 3
SELECT a.au_id AS AUTHOR_ID, a.au_lname AS LAST_NAME, a.au_fname FIRST_NAME, SUM(s.qty) AS total
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN sales s ON ta.title_id = s.title_id
WHERE s.qty IS NOT NULL	
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY total DESC
LIMIT 3
;

-- Challenge 4
SELECT a.au_id AS AUTHOR_ID, a.au_lname AS LAST_NAME, a.au_fname FIRST_NAME, coalesce(SUM(s.qty),0) AS total
FROM authors a
LEFT JOIN titleauthor ta ON a.au_id = ta.au_id
LEFT JOIN sales s ON ta.title_id = s.title_id
GROUP BY a.au_id, a.au_lname, a.au_fname
ORDER BY total DESC
;