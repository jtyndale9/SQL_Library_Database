SELECT *
FROM Borrowed_By;

SELECT 
	Last_Name, first_name, a.member_ID, b.ISBN, title
FROM
	Members a, Borrowed_By b, Book c
WHERE 
	checkin_date = '' AND a.member_ID = b.member_ID AND b.ISBN = c.ISBN
GROUP BY 
	Last_Name, first_name, a.member_ID;


