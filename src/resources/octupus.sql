drop schema octupus CASCADE;
create schema octupus AUTHORIZATION dba;

------------------------------------ MODULE TABLE ------------------------------------------------
CREATE TABLE octupus.MODULE (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name    VARCHAR(30) NOT NULL,
   description VARCHAR(1000),
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

INSERT INTO octupus.MODULE(name, description) VALUES('Books','The book module contains all kinds of books. Here you can maintain and search for books.');
INSERT INTO octupus.MODULE(name, description) VALUES('Contact Person','All your contact persons can be found here. Only contact persons can lend your items.');
INSERT INTO octupus.MODULE(name, description) VALUES('Containers','Containers contain items. A container can be anything, from a file cabinet to a USB stick.');
INSERT INTO octupus.MODULE(name, description) VALUES('Images','Contains pictures and images. Here you can search for and maintain your images.');
INSERT INTO octupus.MODULE(name, description) VALUES('Movie','This module contain movies. Here you can maintain and search for movies.');
INSERT INTO octupus.MODULE(name, description) VALUES('Music Album','Contains music, both audio CD''s and music files can be registered within this module.');
INSERT INTO octupus.MODULE(name, description) VALUES('Software','Contains software such as word processors, utilities and videogames. Search and main these here.');

------------------------------------ CATEGORY TABLE ------------------------------------------------
CREATE TABLE octupus.CATEGORY (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   module_id INTEGER,
   name    VARCHAR(30) NOT NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

ALTER TABLE octupus.CATEGORY ADD CONSTRAINT category_module FOREIGN KEY (module_id) REFERENCES octupus.MODULE (id);

INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Action');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Comic Book');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Encyclopedia');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Fantasy');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Humor');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Movie');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Romance');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Science Fiction');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Study Book');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Technical');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(1, 'Thriller');

INSERT INTO octupus.CATEGORY(module_id, name) VALUES(2, 'Family');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(2, 'Friend');

INSERT INTO octupus.CATEGORY(module_id, name) VALUES(4, 'Family Picture');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(4, 'Wallpaper');

INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, '3D Shooter');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Action Game');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Adventure Game');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Converter');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Driver');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Editor');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Emulator');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Family Game');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Graphics Editor');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Internet');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Operating System');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Racing Game');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Role Playing Game');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'Strategy Game');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'System Tool');
INSERT INTO octupus.CATEGORY(module_id, name) VALUES(7, 'e-Books');

------------------------------------ LANGUAGE TABLE ------------------------------------------------
CREATE TABLE octupus.LANGUAGE (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name    VARCHAR(30) NOT NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

INSERT INTO octupus.LANGUAGE(name) values ('Arabic');
INSERT INTO octupus.LANGUAGE(name) values ('Bengali');
INSERT INTO octupus.LANGUAGE(name) values ('Chinese');
INSERT INTO octupus.LANGUAGE(name) values ('Czech');
INSERT INTO octupus.LANGUAGE(name) values ('Dutch');
INSERT INTO octupus.LANGUAGE(name) values ('English');
INSERT INTO octupus.LANGUAGE(name) values ('Filipino');
INSERT INTO octupus.LANGUAGE(name) values ('French');
INSERT INTO octupus.LANGUAGE(name) values ('German');
INSERT INTO octupus.LANGUAGE(name) values ('Greek');
INSERT INTO octupus.LANGUAGE(name) values ('Hindi');
INSERT INTO octupus.LANGUAGE(name) values ('Indonesian');
INSERT INTO octupus.LANGUAGE(name) values ('Italian');
INSERT INTO octupus.LANGUAGE(name) values ('Japanese');
INSERT INTO octupus.LANGUAGE(name) values ('Korean');
INSERT INTO octupus.LANGUAGE(name) values ('Mandarin');
INSERT INTO octupus.LANGUAGE(name) values ('Portuguese');
INSERT INTO octupus.LANGUAGE(name) values ('Romanian');
INSERT INTO octupus.LANGUAGE(name) values ('Russian');
INSERT INTO octupus.LANGUAGE(name) values ('Spanish');
INSERT INTO octupus.LANGUAGE(name) values ('Thai');
INSERT INTO octupus.LANGUAGE(name) values ('Turkish');
INSERT INTO octupus.LANGUAGE(name) values ('Vietnamese');
INSERT INTO octupus.LANGUAGE(name) values ('Wu');
INSERT INTO octupus.LANGUAGE(name) values ('Yoruba');

------------------------------------ COUNTRY TABLE ------------------------------------------------
CREATE TABLE octupus.COUNTRY (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name    VARCHAR(50) NOT NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

INSERT INTO octupus.COUNTRY(name) values ('Afghanistan');
INSERT INTO octupus.COUNTRY(name) values ('Aland Islands');
INSERT INTO octupus.COUNTRY(name) values ('Albania');
INSERT INTO octupus.COUNTRY(name) values ('Algeria');
INSERT INTO octupus.COUNTRY(name) values ('American Samoa');
INSERT INTO octupus.COUNTRY(name) values ('Andorra');
INSERT INTO octupus.COUNTRY(name) values ('Angola');
INSERT INTO octupus.COUNTRY(name) values ('Anguilla');
INSERT INTO octupus.COUNTRY(name) values ('Antigua and Barbuda');
INSERT INTO octupus.COUNTRY(name) values ('Argentina');
INSERT INTO octupus.COUNTRY(name) values ('Armenia');
INSERT INTO octupus.COUNTRY(name) values ('Aruba');
INSERT INTO octupus.COUNTRY(name) values ('Australia');
INSERT INTO octupus.COUNTRY(name) values ('Austria');
INSERT INTO octupus.COUNTRY(name) values ('Azerbaijan');
INSERT INTO octupus.COUNTRY(name) values ('Bahamas');
INSERT INTO octupus.COUNTRY(name) values ('Bahrain');
INSERT INTO octupus.COUNTRY(name) values ('Bangladesh');
INSERT INTO octupus.COUNTRY(name) values ('Barbados');
INSERT INTO octupus.COUNTRY(name) values ('Belarus');
INSERT INTO octupus.COUNTRY(name) values ('Belgium');
INSERT INTO octupus.COUNTRY(name) values ('Belize');
INSERT INTO octupus.COUNTRY(name) values ('Benin');
INSERT INTO octupus.COUNTRY(name) values ('Bermuda');
INSERT INTO octupus.COUNTRY(name) values ('Bhutan');
INSERT INTO octupus.COUNTRY(name) values ('Bolivia, Plurinational State of');
INSERT INTO octupus.COUNTRY(name) values ('Bosnia and Herzegovina');
INSERT INTO octupus.COUNTRY(name) values ('Botswana');
INSERT INTO octupus.COUNTRY(name) values ('Bouvet Island');
INSERT INTO octupus.COUNTRY(name) values ('Brazil');
INSERT INTO octupus.COUNTRY(name) values ('Brunei Darussalam');
INSERT INTO octupus.COUNTRY(name) values ('Bulgaria');
INSERT INTO octupus.COUNTRY(name) values ('Burkina Faso');
INSERT INTO octupus.COUNTRY(name) values ('Burundi');
INSERT INTO octupus.COUNTRY(name) values ('Cambodia');
INSERT INTO octupus.COUNTRY(name) values ('Cameroon');
INSERT INTO octupus.COUNTRY(name) values ('Canada');
INSERT INTO octupus.COUNTRY(name) values ('Cape Verde');
INSERT INTO octupus.COUNTRY(name) values ('Cayman Islands');
INSERT INTO octupus.COUNTRY(name) values ('Central African Republic');
INSERT INTO octupus.COUNTRY(name) values ('Chad');
INSERT INTO octupus.COUNTRY(name) values ('Chile');
INSERT INTO octupus.COUNTRY(name) values ('China');
INSERT INTO octupus.COUNTRY(name) values ('Christmas Island');
INSERT INTO octupus.COUNTRY(name) values ('Cocos (Keeling) Islands');
INSERT INTO octupus.COUNTRY(name) values ('Colombia');
INSERT INTO octupus.COUNTRY(name) values ('Comoros');
INSERT INTO octupus.COUNTRY(name) values ('Congo');
INSERT INTO octupus.COUNTRY(name) values ('Congo, the Democratic Republic of the');
INSERT INTO octupus.COUNTRY(name) values ('Cook Islands');
INSERT INTO octupus.COUNTRY(name) values ('Costa Rica');
INSERT INTO octupus.COUNTRY(name) values ('Cote d''Ivoire');
INSERT INTO octupus.COUNTRY(name) values ('Croatia');
INSERT INTO octupus.COUNTRY(name) values ('Cuba');
INSERT INTO octupus.COUNTRY(name) values ('Cyprus');
INSERT INTO octupus.COUNTRY(name) values ('Czech Republic');
INSERT INTO octupus.COUNTRY(name) values ('Denmark');
INSERT INTO octupus.COUNTRY(name) values ('Djibouti');
INSERT INTO octupus.COUNTRY(name) values ('Dominica');
INSERT INTO octupus.COUNTRY(name) values ('Dominican Republic');
INSERT INTO octupus.COUNTRY(name) values ('Ecuador');
INSERT INTO octupus.COUNTRY(name) values ('Egypt');
INSERT INTO octupus.COUNTRY(name) values ('El Salvador');
INSERT INTO octupus.COUNTRY(name) values ('Equatorial Guinea');
INSERT INTO octupus.COUNTRY(name) values ('Eritrea');
INSERT INTO octupus.COUNTRY(name) values ('Estonia');
INSERT INTO octupus.COUNTRY(name) values ('Ethiopia');
INSERT INTO octupus.COUNTRY(name) values ('Falkland Islands');
INSERT INTO octupus.COUNTRY(name) values ('Faroe Islands');
INSERT INTO octupus.COUNTRY(name) values ('Fiji');
INSERT INTO octupus.COUNTRY(name) values ('Finland');
INSERT INTO octupus.COUNTRY(name) values ('France');
INSERT INTO octupus.COUNTRY(name) values ('French Guiana');
INSERT INTO octupus.COUNTRY(name) values ('French Polynesia');
INSERT INTO octupus.COUNTRY(name) values ('French Southern Territories');
INSERT INTO octupus.COUNTRY(name) values ('Gabon');
INSERT INTO octupus.COUNTRY(name) values ('Gambia');
INSERT INTO octupus.COUNTRY(name) values ('Georgia');
INSERT INTO octupus.COUNTRY(name) values ('Germany');
INSERT INTO octupus.COUNTRY(name) values ('Ghana');
INSERT INTO octupus.COUNTRY(name) values ('Gibraltar');
INSERT INTO octupus.COUNTRY(name) values ('Greece');
INSERT INTO octupus.COUNTRY(name) values ('Greenland');
INSERT INTO octupus.COUNTRY(name) values ('Grenada');
INSERT INTO octupus.COUNTRY(name) values ('Guadeloupe');
INSERT INTO octupus.COUNTRY(name) values ('Guam');
INSERT INTO octupus.COUNTRY(name) values ('Guatemala');
INSERT INTO octupus.COUNTRY(name) values ('Guinea');
INSERT INTO octupus.COUNTRY(name) values ('Guinea-Bissau');
INSERT INTO octupus.COUNTRY(name) values ('Guyana');
INSERT INTO octupus.COUNTRY(name) values ('Haiti');
INSERT INTO octupus.COUNTRY(name) values ('Honduras');
INSERT INTO octupus.COUNTRY(name) values ('Hong Kong');
INSERT INTO octupus.COUNTRY(name) values ('Hungary');
INSERT INTO octupus.COUNTRY(name) values ('Iceland');
INSERT INTO octupus.COUNTRY(name) values ('India');
INSERT INTO octupus.COUNTRY(name) values ('Indonesia');
INSERT INTO octupus.COUNTRY(name) values ('Iran');
INSERT INTO octupus.COUNTRY(name) values ('Iraq');
INSERT INTO octupus.COUNTRY(name) values ('Ireland');
INSERT INTO octupus.COUNTRY(name) values ('Isle of Man');
INSERT INTO octupus.COUNTRY(name) values ('Israel');
INSERT INTO octupus.COUNTRY(name) values ('Italy');
INSERT INTO octupus.COUNTRY(name) values ('Jamaica');
INSERT INTO octupus.COUNTRY(name) values ('Japan');
INSERT INTO octupus.COUNTRY(name) values ('Jordan');
INSERT INTO octupus.COUNTRY(name) values ('Kazakhstan');
INSERT INTO octupus.COUNTRY(name) values ('Kenya');
INSERT INTO octupus.COUNTRY(name) values ('Kiribati');
INSERT INTO octupus.COUNTRY(name) values ('Korea, Democratic People''s Republic of');
INSERT INTO octupus.COUNTRY(name) values ('Korea, Republic of');
INSERT INTO octupus.COUNTRY(name) values ('Kuwait');
INSERT INTO octupus.COUNTRY(name) values ('Kyrgyzstan');
INSERT INTO octupus.COUNTRY(name) values ('Lao People''s Democratic Republic');
INSERT INTO octupus.COUNTRY(name) values ('Latvia');
INSERT INTO octupus.COUNTRY(name) values ('Lebanon');
INSERT INTO octupus.COUNTRY(name) values ('Lesotho');
INSERT INTO octupus.COUNTRY(name) values ('Liberia');
INSERT INTO octupus.COUNTRY(name) values ('Libyan Arab Jamahiriya');
INSERT INTO octupus.COUNTRY(name) values ('Liechtenstein');
INSERT INTO octupus.COUNTRY(name) values ('Lithuania');
INSERT INTO octupus.COUNTRY(name) values ('Luxembourg');
INSERT INTO octupus.COUNTRY(name) values ('Macao');
INSERT INTO octupus.COUNTRY(name) values ('Macedonia');
INSERT INTO octupus.COUNTRY(name) values ('Madagascar');
INSERT INTO octupus.COUNTRY(name) values ('Malawi');
INSERT INTO octupus.COUNTRY(name) values ('Malaysia');
INSERT INTO octupus.COUNTRY(name) values ('Maldives');
INSERT INTO octupus.COUNTRY(name) values ('Mali');
INSERT INTO octupus.COUNTRY(name) values ('Malta');
INSERT INTO octupus.COUNTRY(name) values ('Marshall Islands');
INSERT INTO octupus.COUNTRY(name) values ('Martinique');
INSERT INTO octupus.COUNTRY(name) values ('Mauritania');
INSERT INTO octupus.COUNTRY(name) values ('Mauritius');
INSERT INTO octupus.COUNTRY(name) values ('Mayotte');
INSERT INTO octupus.COUNTRY(name) values ('Mexico');
INSERT INTO octupus.COUNTRY(name) values ('Moldova, Republic of');
INSERT INTO octupus.COUNTRY(name) values ('Monaco');
INSERT INTO octupus.COUNTRY(name) values ('Mongolia');
INSERT INTO octupus.COUNTRY(name) values ('Montenegro');
INSERT INTO octupus.COUNTRY(name) values ('Montserrat');
INSERT INTO octupus.COUNTRY(name) values ('Morocco');
INSERT INTO octupus.COUNTRY(name) values ('Mozambique');
INSERT INTO octupus.COUNTRY(name) values ('Myanmar');
INSERT INTO octupus.COUNTRY(name) values ('Namibia');
INSERT INTO octupus.COUNTRY(name) values ('Nauru');
INSERT INTO octupus.COUNTRY(name) values ('Nepal');
INSERT INTO octupus.COUNTRY(name) values ('Netherlands Antilles');
INSERT INTO octupus.COUNTRY(name) values ('Netherlands');
INSERT INTO octupus.COUNTRY(name) values ('New Caledonia');
INSERT INTO octupus.COUNTRY(name) values ('New Zealand');
INSERT INTO octupus.COUNTRY(name) values ('Nicaragua');
INSERT INTO octupus.COUNTRY(name) values ('Niger');
INSERT INTO octupus.COUNTRY(name) values ('Nigeria');
INSERT INTO octupus.COUNTRY(name) values ('Niue');
INSERT INTO octupus.COUNTRY(name) values ('Norfolk Island');
INSERT INTO octupus.COUNTRY(name) values ('Northern Mariana Islands');
INSERT INTO octupus.COUNTRY(name) values ('Norway');
INSERT INTO octupus.COUNTRY(name) values ('Oman');
INSERT INTO octupus.COUNTRY(name) values ('Pakistan');
INSERT INTO octupus.COUNTRY(name) values ('Palau');
INSERT INTO octupus.COUNTRY(name) values ('Palestinian Territory, Occupied');
INSERT INTO octupus.COUNTRY(name) values ('Panama');
INSERT INTO octupus.COUNTRY(name) values ('Papua New Guinea');
INSERT INTO octupus.COUNTRY(name) values ('Paraguay');
INSERT INTO octupus.COUNTRY(name) values ('Peru');
INSERT INTO octupus.COUNTRY(name) values ('Philippines');
INSERT INTO octupus.COUNTRY(name) values ('Pitcairn');
INSERT INTO octupus.COUNTRY(name) values ('Poland');
INSERT INTO octupus.COUNTRY(name) values ('Portugal');
INSERT INTO octupus.COUNTRY(name) values ('Puerto Rico');
INSERT INTO octupus.COUNTRY(name) values ('Qatar');
INSERT INTO octupus.COUNTRY(name) values ('Reunion');
INSERT INTO octupus.COUNTRY(name) values ('Romania');
INSERT INTO octupus.COUNTRY(name) values ('Russian Federation');
INSERT INTO octupus.COUNTRY(name) values ('Rwanda');
INSERT INTO octupus.COUNTRY(name) values ('Saint Helena');
INSERT INTO octupus.COUNTRY(name) values ('Saint Kitts and Nevis');
INSERT INTO octupus.COUNTRY(name) values ('Saint Lucia');
INSERT INTO octupus.COUNTRY(name) values ('Saint Pierre and Miquelon');
INSERT INTO octupus.COUNTRY(name) values ('Saint Vincent and the Grenadines');
INSERT INTO octupus.COUNTRY(name) values ('Samoa');
INSERT INTO octupus.COUNTRY(name) values ('San Marino');
INSERT INTO octupus.COUNTRY(name) values ('Sao Tome and Principe');
INSERT INTO octupus.COUNTRY(name) values ('Saudi Arabia');
INSERT INTO octupus.COUNTRY(name) values ('Senegal');
INSERT INTO octupus.COUNTRY(name) values ('Serbia');
INSERT INTO octupus.COUNTRY(name) values ('Seychelles');
INSERT INTO octupus.COUNTRY(name) values ('Sierra Leone');
INSERT INTO octupus.COUNTRY(name) values ('Singapore');
INSERT INTO octupus.COUNTRY(name) values ('Slovakia');
INSERT INTO octupus.COUNTRY(name) values ('Slovenia');
INSERT INTO octupus.COUNTRY(name) values ('Solomon Islands');
INSERT INTO octupus.COUNTRY(name) values ('Somalia');
INSERT INTO octupus.COUNTRY(name) values ('South Africa');
INSERT INTO octupus.COUNTRY(name) values ('Spain');
INSERT INTO octupus.COUNTRY(name) values ('Sri Lanka');
INSERT INTO octupus.COUNTRY(name) values ('Sudan');
INSERT INTO octupus.COUNTRY(name) values ('Suriname');
INSERT INTO octupus.COUNTRY(name) values ('Svalbard and Jan Mayen');
INSERT INTO octupus.COUNTRY(name) values ('Swaziland');
INSERT INTO octupus.COUNTRY(name) values ('Sweden');
INSERT INTO octupus.COUNTRY(name) values ('Switzerland');
INSERT INTO octupus.COUNTRY(name) values ('Syrian Arab Republic');
INSERT INTO octupus.COUNTRY(name) values ('Taiwan, Province of China');
INSERT INTO octupus.COUNTRY(name) values ('Tajikistan');
INSERT INTO octupus.COUNTRY(name) values ('Tanzania, United Republic of');
INSERT INTO octupus.COUNTRY(name) values ('Thailand');
INSERT INTO octupus.COUNTRY(name) values ('Timor-Leste');
INSERT INTO octupus.COUNTRY(name) values ('Togo');
INSERT INTO octupus.COUNTRY(name) values ('Tokelau');
INSERT INTO octupus.COUNTRY(name) values ('Tonga');
INSERT INTO octupus.COUNTRY(name) values ('Trinidad and Tobago');
INSERT INTO octupus.COUNTRY(name) values ('Tunisia');
INSERT INTO octupus.COUNTRY(name) values ('Turkey');
INSERT INTO octupus.COUNTRY(name) values ('Turkmenistan');
INSERT INTO octupus.COUNTRY(name) values ('Turks and Caicos Islands');
INSERT INTO octupus.COUNTRY(name) values ('Tuvalu');
INSERT INTO octupus.COUNTRY(name) values ('Uganda');
INSERT INTO octupus.COUNTRY(name) values ('Ukraine');
INSERT INTO octupus.COUNTRY(name) values ('United Arab Emirates');
INSERT INTO octupus.COUNTRY(name) values ('United Kingdom');
INSERT INTO octupus.COUNTRY(name) values ('United States Minor Outlying Islands');
INSERT INTO octupus.COUNTRY(name) values ('United States');
INSERT INTO octupus.COUNTRY(name) values ('Uruguay');
INSERT INTO octupus.COUNTRY(name) values ('Uzbekistan');
INSERT INTO octupus.COUNTRY(name) values ('Vanuatu');
INSERT INTO octupus.COUNTRY(name) values ('Venezuela, Bolivarian Republic of');
INSERT INTO octupus.COUNTRY(name) values ('Viet Nam');
INSERT INTO octupus.COUNTRY(name) values ('Virgin Islands, British');
INSERT INTO octupus.COUNTRY(name) values ('Virgin Islands, U.S.');
INSERT INTO octupus.COUNTRY(name) values ('Wallis and Futuna');
INSERT INTO octupus.COUNTRY(name) values ('Western Sahara');
INSERT INTO octupus.COUNTRY(name) values ('Yemen');
INSERT INTO octupus.COUNTRY(name) values ('Zambia');
INSERT INTO octupus.COUNTRY(name) values ('Zimbabwe');

------------------------------------ STORAGE_MEDIA TABLE ------------------------------------------------
CREATE TABLE octupus.STORAGE_MEDIA (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name    VARCHAR(30) NOT NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

INSERT INTO octupus.STORAGE_MEDIA(name) values ('Blue-Ray Disc');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('CD-ROM');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('DVD-ROM');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('Floppy');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('HD');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('USB Stick');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('CD-R');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('CD+R');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('CD-RW');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('CD+RW');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('DVD-R');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('DVD+R');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('DVD-RW');
INSERT INTO octupus.STORAGE_MEDIA(name) values ('DVD+RW');

------------------------------------ AUTHOR TABLE ------------------------------------------------
CREATE TABLE octupus.AUTHOR (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name VARCHAR(100) NOT NULL,
   firstname    VARCHAR(50),
   lastname    VARCHAR(50),
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

------------------------------------ BOOK TABLE ------------------------------------------------
CREATE TABLE octupus.BOOK (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   title    VARCHAR(30) NOT NULL,
   description VARCHAR(2000) NULL,
   year VARCHAR(4) NULL,
   rating VARCHAR(1) NULL,
   isbn10 VARCHAR(10) NOT NULL,
   isbn13 VARCHAR(13) NOT NULL,
   module_id INTEGER,
   category_id INTEGER,
   language_id INTEGER,
   country_id INTEGER,
   cover binary null,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (title)
);

ALTER TABLE octupus.BOOK ADD CONSTRAINT book_module FOREIGN KEY (module_id) REFERENCES octupus.MODULE (id);
ALTER TABLE octupus.BOOK ADD CONSTRAINT book_category FOREIGN KEY (category_id) REFERENCES octupus.CATEGORY (id);
ALTER TABLE octupus.BOOK ADD CONSTRAINT book_language FOREIGN KEY (language_id) REFERENCES octupus.LANGUAGE (id);
ALTER TABLE octupus.BOOK ADD CONSTRAINT book_country FOREIGN KEY (country_id) REFERENCES octupus.COUNTRY (id);

------------------------------------ BOOK_AUTHOR TABLE ------------------------------------------------
CREATE TABLE octupus.BOOK_AUTHOR (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   book_id INTEGER,
   author_id INTEGER,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id)
);

ALTER TABLE octupus.BOOK_AUTHOR ADD CONSTRAINT book_author_author FOREIGN KEY (author_id) REFERENCES octupus.AUTHOR (id);
ALTER TABLE octupus.BOOK_AUTHOR ADD CONSTRAINT book_author_book FOREIGN KEY (book_id) REFERENCES octupus.BOOK (id);

------------------------------------ SOFTWARE_PLATFORM TABLE ------------------------------------------------
CREATE TABLE octupus.SOFTWARE_PLATFORM (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name    VARCHAR(30) NOT NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Amiga');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Atari');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Commodore 64');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Linux');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Mac OS X');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Mandrake');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Nintendo Wii');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Nintendo SNES');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('OS Independent');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('PSP');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('PlayStation 2');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('PlayStation 3');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('PlayStation 4');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('PlayStation');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('RedHat Linux');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('SEGA Master System');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('SEGA Mega Drive');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('SuSE Linux');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows (16-bit)');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows 2000');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows 7');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows 8');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows 95');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows 98');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows Vista');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows XP');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('Windows');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('XBOX 360');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('XBOX');
INSERT INTO octupus.SOFTWARE_PLATFORM(name) values ('XBOX One');

------------------------------------ SOFTWARE TABLE ------------------------------------------------
CREATE TABLE octupus.SOFTWARE (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   module_id INTEGER NULL,
   language_id INTEGER NULL,
   country_id INTEGER NULL,
   software_platform_id INTEGER NULL,
   storage_media_id INTEGER NULL,
   title    VARCHAR(50) NOT NULL,
   description VARCHAR(4000) NOT NULL,
   version VARCHAR(20) NULL,
   serialkey VARCHAR(100) NULL,
   year VARCHAR(4) NULL,
   rating VARCHAR(1) NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (title, software_platform_id)
);

ALTER TABLE octupus.SOFTWARE ADD CONSTRAINT software_module FOREIGN KEY (module_id) REFERENCES octupus.MODULE (id);
ALTER TABLE octupus.SOFTWARE ADD CONSTRAINT software_language FOREIGN KEY (language_id) REFERENCES octupus.LANGUAGE (id);
ALTER TABLE octupus.SOFTWARE ADD CONSTRAINT software_country FOREIGN KEY (country_id) REFERENCES octupus.COUNTRY (id);
ALTER TABLE octupus.SOFTWARE ADD CONSTRAINT software_software_plaftorm FOREIGN KEY (software_platform_id) REFERENCES octupus.SOFTWARE_PLATFORM (id);
ALTER TABLE octupus.SOFTWARE ADD CONSTRAINT software_storage_media FOREIGN KEY (storage_media_id) REFERENCES octupus.STORAGE_MEDIA (id);

------------------------------------ SOFTWARE_CATEGORY TABLE ------------------------------------------------
CREATE TABLE octupus.SOFTWARE_CATEGORY (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   software_id INTEGER,
   category_id INTEGER,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id)
);

ALTER TABLE octupus.SOFTWARE_CATEGORY ADD CONSTRAINT software_category_software FOREIGN KEY (software_id) REFERENCES octupus.SOFTWARE (id);
ALTER TABLE octupus.SOFTWARE_CATEGORY ADD CONSTRAINT software_category_category FOREIGN KEY (category_id) REFERENCES octupus.CATEGORY (id);

------------------------------------ MUSIC_GENRE TABLE ------------------------------------------------
CREATE TABLE octupus.MUSIC_GENRE (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name    VARCHAR(30) NOT NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

INSERT INTO octupus.MUSIC_GENRE(name) values ('A Capela');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Acid Jazz');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Acid Punk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Acid');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Acoustic');
INSERT INTO octupus.MUSIC_GENRE(name) values ('AlternRock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Alternative');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Ambient');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Anime');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Avantgarde');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Ballad');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Bass');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Beat');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Bebob');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Big Band');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Black Metal');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Bluegrass');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Blues');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Booty Brass');
INSERT INTO octupus.MUSIC_GENRE(name) values ('BritPop');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Cabaret');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Celtic');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Chamber Music');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Chanson');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Chorus');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Christian Gangsta Rap');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Christian Rap');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Christian Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Classic Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Classical');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Club');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Club-House');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Comedy');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Contemporary Christian');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Country');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Crossover');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Cult');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Dance Hall');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Dance');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Darkwave');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Death Metal');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Disco');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Dream');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Drum & Bass');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Drum Solo');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Duet');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Easy Listening');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Electronic');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Ethnic');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Euro-House');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Euro-Techno');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Eurodance');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Fast Fusion');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Folk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Folk-Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Folklore');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Freestyle');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Funk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Fusion');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Game');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Gangsta');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Goa');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Gospel');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Gothic Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Gothic');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Grunge');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Hard Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Hardcore');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Heavy Metal');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Hip-Hop');
INSERT INTO octupus.MUSIC_GENRE(name) values ('House');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Humour');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Indie');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Industrial');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Instrumental Pop');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Instrumental Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Instrumental');
INSERT INTO octupus.MUSIC_GENRE(name) values ('JPop');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Jazz');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Jazz+Funk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Jungle');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Latin');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Lo-Fi');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Meditative');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Merengue');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Metal');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Musical');
INSERT INTO octupus.MUSIC_GENRE(name) values ('National Folk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Native American');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Negerpunk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('New Age');
INSERT INTO octupus.MUSIC_GENRE(name) values ('New Wave');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Noise');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Oldies');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Opera');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Other');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Polka');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Polsk Punk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Pop');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Pop-Folk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Pop/Funk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Porn Groove');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Power Ballad');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Pranks');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Primus');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Progressive Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Psychadelic');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Psychedelic Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Punk Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Punk');
INSERT INTO octupus.MUSIC_GENRE(name) values ('R&B');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Rap');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Rave');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Reggae');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Retro');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Revival');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Rhythmic Soul');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Rock & Roll');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Salsa');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Samba');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Satire');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Showtunes');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Ska');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Slow Jam');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Slow Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Sonata');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Soul');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Sound Clip');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Soundtrack');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Southern Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Space');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Speech');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Swing');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Symphonic Rock');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Symphony');
INSERT INTO octupus.MUSIC_GENRE(name) values ('SynthPop');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Tango');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Techno');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Techno-Industrial');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Terror');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Thrash Metal');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Top 40');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Trailer');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Trance');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Tribal');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Trip-Hop');
INSERT INTO octupus.MUSIC_GENRE(name) values ('Vocal');

------------------------------------ MOVIE_GENRE TABLE ------------------------------------------------
CREATE TABLE octupus.MOVIE_GENRE (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   name    VARCHAR(30) NOT NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

INSERT INTO octupus.MOVIE_GENRE(name) values ('Action');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Adult Film');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Adventure');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Animation');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Children''s Film');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Comedy');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Crime');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Documentary');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Drama');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Family Film');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Fantasy');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Film Noir');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Historical');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Horror');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Musical');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Mystery');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Romance');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Science Fiction');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Sports');
INSERT INTO octupus.MOVIE_GENRE(name) values ('War');
INSERT INTO octupus.MOVIE_GENRE(name) values ('Western');

------------------------------------ PERSON TABLE ------------------------------------------------
CREATE TABLE octupus.PERSON (
   id      INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   category_id INTEGER,
   country_id INTEGER,
   name    VARCHAR(30) NOT NULL,
   email    VARCHAR(50) NULL,
   description VARCHAR(500) NULL,
   address VARCHAR(500) NULL,
   city VARCHAR(500) NULL,
   phone VARCHAR(20) NULL,
   mobile VARCHAR(20) NULL,
   created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   modified TIMESTAMP,
   PRIMARY KEY (id),
   UNIQUE (name)
);

ALTER TABLE octupus.PERSON ADD CONSTRAINT person_category FOREIGN KEY (category_id) REFERENCES octupus.CATEGORY (id);
ALTER TABLE octupus.PERSON ADD CONSTRAINT person_country FOREIGN KEY (country_id) REFERENCES octupus.COUNTRY (id);

-------------------------------------------------- SAMPLE DATA -------------------------------------
INSERT INTO octupus.AUTHOR(name) values ('J.K.Rowling');
INSERT INTO octupus.AUTHOR(name) values ('Esopo');
INSERT INTO octupus.AUTHOR(name) values ('Irmãos Grimm');
INSERT INTO octupus.AUTHOR(name) values ('Hans Christian Andersen');

INSERT INTO octupus.BOOK(title, isbn10, isbn13, module_id, category_id, language_id, country_id) values ('A Bela Adormecida', '10', '13', 1, 1, 1, 1);

INSERT INTO octupus.BOOK_AUTHOR(book_id, author_id) values (1, 3);

