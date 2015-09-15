drop schema rbac CASCADE;
create schema rbac AUTHORIZATION dba;

/***************************************************************************
 * Table      : USER
 * Purpose    : 
 * Description: 
 ***************************************************************************/
DROP TABLE IF EXISTS rbac.USER CASCADE;
CREATE TABLE rbac.USER
(
  id integer GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) not null,
  username varchar(20) not null,
  password varchar(100) not null,
  CONSTRAINT user_uniq_username unique(username)
);  

/***************************************************************************
 * Table      : ROLE
 * Purpose    : 
 * Description: 
 ***************************************************************************/
DROP TABLE IF EXISTS rbac.ROLE CASCADE;
CREATE TABLE rbac.ROLE
(
  id integer GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) not null,
  rolename varchar(20) not null,
  CONSTRAINT user_uniq_rolename unique(rolename)
); 

/***************************************************************************
 * Table      : USER_ROLE
 * Purpose    : 
 * Description: 
 ***************************************************************************/
DROP TABLE IF EXISTS rbac.USER_ROLE CASCADE;
CREATE TABLE rbac.USER_ROLE
(
  id integer GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) not null,
  user_id integer not null,
  role_id integer not null,
  CONSTRAINT fk_user_user_role FOREIGN KEY (user_id) REFERENCES USER (id),
  CONSTRAINT fk_role_user_role FOREIGN KEY (role_id) REFERENCES ROLE (id)
); 

/***************************************************************************
 * Table      : PERMISSION
 * Purpose    : 
 * Description: 
 ***************************************************************************/
DROP TABLE IF EXISTS rbac.PERMISSION CASCADE;
CREATE TABLE rbac.PERMISSION
(
  id integer GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) not null,
  name varchar(20) not null,
  CONSTRAINT permission_uniq_name unique(name)
); 

/***************************************************************************
 * Table      : ROLE_PERMISSION
 * Purpose    : 
 * Description: 
 ***************************************************************************/
DROP TABLE IF EXISTS rbac.ROLE_PERMISSION CASCADE;
CREATE TABLE rbac.ROLE_PERMISSION
(
  id integer GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) not null,
  role_id integer not null,
  permission_id integer not null,
  CONSTRAINT fk_role_role_permission FOREIGN KEY (role_id) REFERENCES ROLE (id),
  CONSTRAINT fk_permission_role_permission FOREIGN KEY (permission_id) REFERENCES PERMISSION (id)
); 

/***************************************************************************
 * Table      : OPERATION
 * Purpose    : 
 * Description: 
 ***************************************************************************/
DROP TABLE IF EXISTS rbac.OPERATION CASCADE;
CREATE TABLE rbac.OPERATION
(
  id integer GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) not null,
  name varchar(20) not null,
  CONSTRAINT operation_uniq_name unique(name)
); 

/***************************************************************************
 * Table      : PERMISSION_OPERATION
 * Purpose    : 
 * Description: 
 ***************************************************************************/
DROP TABLE IF EXISTS rbac.PERMISSION_OPERATION CASCADE;
CREATE TABLE rbac.PERMISSION_OPERATION
(
  id integer GENERATED BY DEFAULT AS IDENTITY (START WITH 1, INCREMENT BY 1) not null,
  operation_id integer not null,
  permission_id integer not null,
  CONSTRAINT fk_operation_permission_operation FOREIGN KEY (operation_id) REFERENCES OPERATION (id),
  CONSTRAINT fk_permission_permission_operation FOREIGN KEY (permission_id) REFERENCES PERMISSION (id)
); 

