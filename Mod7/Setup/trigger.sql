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










