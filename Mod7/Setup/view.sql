CREATE SQL SECURITY INVOKER 
VIEW viewMod7Lab
AS
SELECT
	title, GROUP_CONCAT(first_name, last_name) as Authors, Shelf_Number, Name
FROM
	Located_at s, Book b, Written_By w, Author a
WHERE
	s.ISBN=b.ISBN AND w.ISBN=b.ISBN AND a.Author_ID=w.Author_ID
GROUP BY s.ISBN, s.Name;

