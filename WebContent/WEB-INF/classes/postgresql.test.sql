CREATE TABLE "author"
(
   id int PRIMARY KEY NOT NULL,
   first_name varchar(20),
   last_name varchar(20),
   middle_initial varchar(1),
   pen_name varchar(40)
);

CREATE TABLE "book"
(
   id int PRIMARY KEY NOT NULL,
   author_id int,
   title varchar(100),
   publishing_date date
);

ALTER TABLE "book"
ADD CONSTRAINT book_author_id_fkey
FOREIGN KEY (author_id)
REFERENCES "author"(id);

