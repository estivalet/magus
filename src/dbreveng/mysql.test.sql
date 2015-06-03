DROP TABLE IF EXISTS author;

CREATE TABLE author (
   id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
   first_name varchar(20),
   last_name varchar(20),
   middle_initial varchar(1),
   pen_name varchar(40)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS book;

CREATE TABLE book (
   id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
   author_id int NOT NULL,
   title varchar(100),
   publishing_date date
) ENGINE=InnoDB;

ALTER TABLE book ADD CONSTRAINT book_author_id_fkey FOREIGN KEY (author_id) REFERENCES author(id);

