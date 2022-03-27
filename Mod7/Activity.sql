/*Add a new book to the Main library, ISBN # 96-42013-10510, shelf 8, floor 2, Title Growing your own Weeds, published by pubid 10000 on 6/24/2012.*/
INSERT INTO Book (ISBN, title, YearPublished, PubID)
VALUES ('96-42013-10510', 'Growing your own Weeds', 2012, 10000);

INSERT INTO Located_at (Name, ISBN, Shelf_Number, Floor_Number, Total_copies)
VALUES ('Main', '96-42013-10510', 8, 2, 1);



/*Modify the number of copied of ISBN 96-42103-10907 to 8 in the Main library.*/
UPDATE Located_at
SET Total_copies = 8
WHERE ISBN = '96-42103-10907' AND Name = 'Main';


/*Delete Grace Slick from the Author table.*/
DELETE FROM Author
WHERE first_name = 'Grace' AND last_name = 'Slick';


/*Add Commander Adams to the author table, id 305, office phone 970-555-5555*/
INSERT INTO Author (author_ID, first_name, last_name)
VALUES (305, 'Commander', 'Adams');

INSERT INTO Phone (Phone_no, type)
VALUES ('970-555-5555', 'o');

INSERT INTO AuthorPhone (Phone_no, author_ID)
VALUES ('970-555-5555', 305);


/*Add a new book to the South Park library, ISBN # 96-42013-10510, shelf 8, floor 3, Title Growing your own Weeds, published by pubid 10000 on 6/24/2012.*/
/*INSERT INTO Book (ISBN, title, YearPublished, PubID)
VALUES ('96-42013-10510', 'Growing your own Weeds', 2012, 10000);*/
INSERT INTO Located_at (Name, ISBN, Shelf_Number, Floor_Number, Total_copies)
VALUES ('South Park', '96-42013-10510', 8, 3, 1);

/*Delete the book Missing Tomorrow from the Main Library.*/
DELETE FROM Located_at
WHERE Name = 'Main' AND ISBN = (SELECT ISBN FROM Book WHERE title = 'Missing Tomorrow');


/*Add 2 new copies of Eating in the Fort in the South Park library.*/
UPDATE Located_at
SET Total_copies = Total_copies + 2
WHERE ISBN =  (SELECT ISBN FROM Book WHERE title = 'Eating in the Fort');



/*Add a new book to the Main library, ISBN # 96-42013-10513, shelf 8, floor 2, Title Growing your own Weeds, published by pubid 90000 on 6/24/2012.*/
/*INSERT INTO Book (ISBN, title, YearPublished, PubID)
VALUES ('96-42013-10513', 'Growing your own Weeds', 2012, 90000);

INSERT INTO Locted_at (Name, Shelf_Number, Floor_Number, ISBN, Total_copies)
VALUES ('Main', 8, 2, '96-42013-10513', 1);*/


/*Print the final contents of the Audit table.*/
SELECT * FROM metad;

