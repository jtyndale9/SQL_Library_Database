/*List the contents of the Library relation in order according to name.*/
SELECT * FROM Library ORDER BY Name;



/*List the contents of the Located at relation in alphabetic order according to ISBN.*/
SELECT * FROM Located_at ORDER BY ISBN;



/*For each book that has copies in both libraries, list the book name, number of copies, and library sorted by book name.*/
SELECT
	title, b.Total_copies, b.Name
FROM
	Book a, Located_at b, Located_at c
WHERE
	c.ISBN = b.ISBN AND a.ISBN = c.ISBN AND c.Name = 'Main' AND b.Name = 'South Park'
ORDER BY
	title;


/*For each library, list the number of titles sorted by library.*/
SELECT 
	b.Name, COUNT(title)
FROM 
	Book a, Located_at b
WHERE 
	a.ISBN = b.ISBN
GROUP BY 
	b.Name
ORDER BY 
	b.Name;




CREATE TABLE metad (
    tableModified  VARCHAR(15)  NULL,
    action         VARCHAR(10)  NULL, 
    time           datetime     NULL,
    ID             INT(20)      NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (ID)

);





DROP TRIGGER IF EXISTS trigger1;
DROP TRIGGER IF EXISTS trigger2;
DROP TRIGGER IF EXISTS trigger3;
DROP TRIGGER IF EXISTS trigger4;
DROP TRIGGER IF EXISTS addAuthor;
DROP TRIGGER IF EXISTS addBook;
DROP TRIGGER IF EXISTS deleteBook;
DROP TRIGGER IF EXISTS updateBook;

/*Create a set of triggers that stores action, date and time*/

DELIMITER //

/*adds an author*/
CREATE
    TRIGGER addAuthor AFTER INSERT
    ON Author
    FOR EACH ROW BEGIN
	INSERT INTO metad (tableModified, action, time) VALUES ('Author', 'insert', NOW());
END;


/*adds or deletes a book from a library*/
CREATE
    TRIGGER addBook AFTER INSERT
    ON Book
    FOR EACH ROW BEGIN
	INSERT INTO metad (tableModified, action, time) VALUES ('Book', 'insert', NOW());
END;


/*deletes a book from a library*/
CREATE
    TRIGGER deleteBook AFTER DELETE
    ON Book
    FOR EACH ROW BEGIN
	INSERT INTO metad (tableModified, action, time) VALUES ('Book', 'delete', NOW());
END;


/*modifies the number of copies of a book*/
CREATE
    TRIGGER updateBook AFTER UPDATE
    ON Located_at
    FOR EACH ROW BEGIN
	INSERT INTO metad (tableModified, action, time) VALUES ('Located_at', 'update', NOW());
END; 

//






/*Create a view that gives Book name, list of authors, and library name on one line. (Hint: The GROUP_CONCAT clause could be handy here)
Our implementation of using views requires use of the SECURITY INVOKER syntax*/
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



/*Using this view, provide a list of books, authors, shelf, and library name sorted by book name.*/

SELECT 
	*
FROM
	viewMod7Lab
ORDER BY 
	title;

