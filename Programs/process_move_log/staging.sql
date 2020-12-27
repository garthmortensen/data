-- create table to hold filenames
drop table if exists loaded_books;
drop table if exists loaded_books_content;
go

-- create table to log files
create table loaded_books
	(
	processed_time			varchar(256)	not null
	, processed_file		varchar(256)	not null
	);

-- create table to hold file content
create table loaded_books_content
	(
	processed_file			varchar(256)	not null
	, firstlines			varchar(2048)	not null
	);
go


-- insert into loaded_books
insert into loaded_books (processed_time, processed_file)
values ('dec 27', 'merry xmas')
;

-- insert into loaded_books_content
insert into loaded_books_content (processed_file, firstlines)
values ('a christmas carol', 'it was the best of times')
;
go

-- everything work? delete
delete from loaded_books;
delete from loaded_books_content;
go