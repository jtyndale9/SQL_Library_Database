DROP TABLE IF EXISTS 
		     Borrowed_By,
		     PublisherPhone,
		     AuthorPhone,
		     Written_By,
		     Book,
		     Members,
		     Phone,
		     Publisher,
		     Author;

CREATE TABLE Publisher (
    PubID       INT             NOT NULL,
    Pub_Name    VARCHAR(30)     NOT NULL,
    PRIMARY KEY (PubID)
);

CREATE TABLE Author (
    author_ID    INT             NOT NULL,
    first_name   VARCHAR(14)     NOT NULL,
    last_name    VARCHAR(16)     NOT NULL,
    PRIMARY KEY (author_ID)
); 

CREATE TABLE Members (
    member_ID   INT             NOT NULL,
    first_name  VARCHAR(14)     NOT NULL,
    last_name   VARCHAR(16)     NOT NULL,
    birth_date  DATE            NOT NULL,
    gender      VARCHAR(2)      NOT NULL,
    PRIMARY KEY (member_ID)
);

CREATE TABLE Book (
    ISBN        VARCHAR(18)     NOT NULL,
    title       VARCHAR(40)     NOT NULL,
    YearPublished INT		NOT NULL,
    PubID       INT             NOT NULL,
    FOREIGN KEY (PubID) REFERENCES Publisher (PubID) ON DELETE CASCADE,
    PRIMARY KEY (ISBN)
);

CREATE TABLE Written_By (
    ISBN         VARCHAR(18)     NOT NULL,
    author_ID    INT             NOT NULL,
    FOREIGN KEY (ISBN) REFERENCES Book (ISBN) ON DELETE CASCADE,
    FOREIGN KEY (author_ID) REFERENCES Author (author_ID) ON DELETE CASCADE,
    PRIMARY KEY (ISBN, author_ID)
);

CREATE TABLE Phone (
    Phone_no    VARCHAR(12)     NOT NULL,
    type        VARCHAR(3)     NOT NULL,
    PRIMARY KEY (Phone_no)
);

CREATE TABLE AuthorPhone (
    Phone_no     VARCHAR(12)     NOT NULL,
    author_ID    INT             NOT NULL,
    FOREIGN KEY (Phone_no) REFERENCES Phone (Phone_no) ON DELETE CASCADE,
    FOREIGN KEY (author_ID) REFERENCES Author (author_ID) ON DELETE CASCADE,
    PRIMARY KEY (Phone_no, author_ID)
);

CREATE TABLE PublisherPhone (
    Phone_no    VARCHAR(12)     NOT NULL,
    PubID       INT             NOT NULL,
    FOREIGN KEY (Phone_no) REFERENCES Phone (Phone_no) ON DELETE CASCADE,
    FOREIGN KEY (PubID) REFERENCES Publisher (PubID) ON DELETE CASCADE,
    PRIMARY KEY (Phone_no, PubID)
);

CREATE TABLE Borrowed_By (
    member_ID      INT             NOT NULL,
    ISBN           VARCHAR(18)     NOT NULL,
    checkout_date  VARCHAR(18)     NOT NULL,
    checkin_date   VARCHAR(18)     ,
    FOREIGN KEY (member_ID)  REFERENCES Members   (member_ID)  ON DELETE CASCADE,
    FOREIGN KEY (ISBN)  REFERENCES Book   (ISBN)  ON DELETE CASCADE,
    PRIMARY KEY (member_ID, ISBN, checkout_date)
);

/*-------------------NEW TABLES-------------------------------*/


CREATE TABLE Library (
    Name        VARCHAR(12)     NOT NULL,
    Street      VARCHAR(20)     NOT NULL,
    City        VARCHAR(12)     NOT NULL,
    State       VARCHAR(12)     NOT NULL,
    PRIMARY KEY (Name)
);

CREATE TABLE Located_at (
    Name          VARCHAR(12)     NOT NULL,
    ISBN          VARCHAR(18)     NOT NULL,
    Shelf_Number  INT             NOT NULL,
    Floor_Number  INT             NOT NULL,
    Total_copies  INT             NOT NULL,
    FOREIGN KEY (Name)  REFERENCES Library (Name)  ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Book (ISBN) ON DELETE CASCADE,
    PRIMARY KEY (Name, ISBN)
);
/*    Copies_avail  INT 		  NOT NULL,*/






/*CREATE TABLE Stored_On (
    Name          VARCHAR(12)     NOT NULL,
    Shelf_Number  INT             NOT NULL,
    Floor_Number  INT             NOT NULL,
    ISBN          VARCHAR(18)     NOT NULL,
    Total_copies  INT             NOT NULL,
    FOREIGN KEY (Name,Shelf_Number,Floor_Number)  REFERENCES Shelf
		 (Name,Shelf_Number,Floor_Number)  ON DELETE CASCADE,
    FOREIGN KEY (ISBN) REFERENCES Book (ISBN) ON DELETE CASCADE,
    PRIMARY KEY (Name, Shelf_Number, Floor_Number, ISBN)
);*/


