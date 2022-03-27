Joshua Tyndale
CS430
3/11/2021
Mod 7 Lab


## Usage
createTables.sql 	: Used to create the tables for the dataBase
loadLab.sql 		: Loads the data from the .dump files into my tables
queries_setp4-8_.sql 	: These queries are in the step 4-8 of the setup 
Activity.sql 		: The Activity file implements the last half of the lab
output.txt 		: The output file is the output of what I got from running all of these file
README.txt		: This file.




Activity discussion:

The only activity query that was not possible for me was the: 

	"Add a new book to the Main library, ISBN # 96-42013-10513, shelf 8, floor 2, Title Growing your own Weeds, published by pubid 90000 on 6/24/2012."

This was not possible due to my referential integrity constraints. I do not have a pubisher with a pubId of 90000. In order for me to do this, I would need to add a publisher that has an ID of 90000. Other than that, all queries worked.
