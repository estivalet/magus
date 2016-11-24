drop schema livraria CASCADE;
create schema livraria AUTHORIZATION dba;

CREATE TABLE livraria.LIVRO (
   id              INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   titulo          VARCHAR(30) NOT NULL,
   isbn            VARCHAR(20),
   preco           DECIMAL(10,2),
   data_lancamento TIMESTAMP,
   PRIMARY KEY (id)
);

CREATE TABLE livraria.AUTOR (
   id              INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   nome            VARCHAR(50) NOT NULL,
   PRIMARY KEY (id)
);

CREATE TABLE livraria.LIVRO_AUTOR (
   id_livro INTEGER,
   id_autor INTEGER
);

ALTER TABLE livraria.LIVRO_AUTOR ADD CONSTRAINT livria_autor_livro FOREIGN KEY (id_livro) REFERENCES livraria.LIVRO (id);
ALTER TABLE livraria.LIVRO_AUTOR ADD CONSTRAINT livria_autor_autor FOREIGN KEY (id_autor) REFERENCES livraria.AUTOR (id);

CREATE TABLE livraria.USUARIO (
   id              INTEGER GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1),
   email           VARCHAR(30) NOT NULL,
   senha           VARCHAR(20),
   PRIMARY KEY (id)
);

INSERT INTO MW_APPLICATION(ID,NAME,SHORT_NAME,DESCRIPTION,PATH,COPYRIGHT,LICENSE_FILE,TEMPLATE,ARCHITECTURE,RECORDS_PER_PAGE,USER) VALUES (10,'livraria','livraria','','C:/apache-tomcat-7.0.53/webapps/livraria',null,null,'pure','JSF',null,null);
INSERT INTO MW_APPLICATION_DATABASE(APP_ID,DB_TYPE,DATA_SOURCE,DRIVER,CONNECTION_STRING,CONNECTION_IMPL,USERNAME,PASSWORD) VALUES (10,'HSQLDB','ds','driver','jdbc:hsqldb:hsql://localhost/magusdb','connimpl','sa','');

