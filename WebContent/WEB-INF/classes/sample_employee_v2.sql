drop schema sample CASCADE;
create schema sample AUTHORIZATION dba;

CREATE TABLE sample.TESTGUI(
   id      INTEGER NOT NULL,
   name       VARCHAR(80),
   textarea   VARCHAR(2000),
   data       DATE,
   radio   VARCHAR(20),
   checkbox    VARCHAR(20),
   PRIMARY KEY (id)
);


CREATE TABLE sample.EMPLOYEE(
   empno      INTEGER NOT NULL,
   name       VARCHAR(10),
   job        VARCHAR(9),
   boss       INTEGER,
   hiredate   VARCHAR(12),
   salary     DECIMAL(7, 2),
   comm       DECIMAL(7, 2),
   deptno     INTEGER,
   PRIMARY KEY (empno)
);

CREATE TABLE sample.DEPARTMENT(
   deptno     INTEGER NOT NULL,
   name       VARCHAR(14),
   location   VARCHAR(13),
   PRIMARY KEY (deptno)
);

CREATE TABLE sample.SALARYGRADE(
   grade      INTEGER NOT NULL,
   losal      INTEGER NOT NULL,
   hisal      INTEGER NOT NULL,
   PRIMARY KEY (grade)
);

CREATE TABLE sample.BONUS (
   ename      VARCHAR(10) NOT NULL,
   job        VARCHAR(9) NOT NULL,
   sal        DECIMAL(7, 2),
   comm       DECIMAL(7, 2),
   PRIMARY KEY (ename,job)
);

CREATE TABLE sample.PROJECT(
   projectno    INTEGER NOT NULL,
   description  VARCHAR(100),
   start_date   VARCHAR(12),
   end_date     VARCHAR(12),
   PRIMARY KEY (projectno)
);

CREATE TABLE sample.PROJECT_PARTICIPATION(
   projectno    INTEGER NOT NULL,
   empno        INTEGER NOT NULL,
   start_date   VARCHAR(12) NOT NULL,
   end_date     VARCHAR(12),
   role_id      INTEGER,
   PRIMARY KEY (projectno, empno, start_date)
);

CREATE TABLE sample.ROLE(
   role_id      INTEGER NOT NULL,
   description  VARCHAR(100),
   PRIMARY KEY (role_id)
);

ALTER TABLE sample.EMPLOYEE
   ADD CONSTRAINT department
   FOREIGN KEY (deptno)
   REFERENCES sample.DEPARTMENT (deptno);

ALTER TABLE sample.EMPLOYEE
   ADD CONSTRAINT boss
   FOREIGN KEY (boss)
   REFERENCES sample.EMPLOYEE (empno);
 
-- EMPLOYEE to PROJECT_PARTICIPATION
ALTER TABLE sample.PROJECT_PARTICIPATION
   ADD CONSTRAINT employee
   FOREIGN KEY (empno)
   REFERENCES sample.EMPLOYEE (empno);

-- PROJECT to PROJECT_PARTICIPATION
ALTER TABLE sample.PROJECT_PARTICIPATION
   ADD CONSTRAINT project
   FOREIGN KEY (projectno)
   REFERENCES sample.PROJECT (projectno);

-- ROLE to PROJECT_PARTICIPATION
ALTER TABLE sample.PROJECT_PARTICIPATION
   ADD CONSTRAINT role
   FOREIGN KEY (role_id)
   REFERENCES sample.ROLE (role_id);   

-- data
INSERT INTO sample.DEPARTMENT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO sample.DEPARTMENT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO sample.DEPARTMENT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO sample.DEPARTMENT VALUES (40, 'OPERATIONS', 'BOSTON');
 
INSERT INTO sample.EMPLOYEE VALUES (7839, 'KING',   'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10);
INSERT INTO sample.EMPLOYEE VALUES (7566, 'JONES',  'MANAGER',   7839, '1981-04-02',  2975, NULL, 20);
INSERT INTO sample.EMPLOYEE VALUES(7788, 'SCOTT',  'ANALYST',   7566, '1982-12-09', 3000, NULL, 20);
INSERT INTO sample.EMPLOYEE VALUES(7876, 'ADAMS',  'CLERK',     7788, '1983-01-12', 1100, NULL, 20);
INSERT INTO sample.EMPLOYEE VALUES(7902, 'FORD',   'ANALYST',   7566, '1981-12-03',  3000, NULL, 20);
INSERT INTO sample.EMPLOYEE VALUES(7369, 'SMITH',  'CLERK',     7902, '1980-12-17',  800, NULL, 20);
INSERT INTO sample.EMPLOYEE VALUES (7698, 'BLAKE',  'MANAGER',   7839, '1981-05-01',  2850, NULL, 30);
INSERT INTO sample.EMPLOYEE VALUES(7499, 'ALLEN',  'SALESMAN',  7698, '1981-02-20', 1600,  300, 30);
INSERT INTO sample.EMPLOYEE VALUES(7521, 'WARD',   'SALESMAN',  7698, '1981-02-22', 1250,  500, 30);
INSERT INTO sample.EMPLOYEE VALUES(7654, 'MARTIN', 'SALESMAN',  7698, '1981-09-28', 1250, 1400, 30);
INSERT INTO sample.EMPLOYEE VALUES(7844, 'TURNER', 'SALESMAN',  7698, '1981-09-08',  1500,    0, 30);
INSERT INTO sample.EMPLOYEE VALUES(7900, 'JAMES',  'CLERK',     7698, '1981-12-03',   950, NULL, 30);
INSERT INTO sample.EMPLOYEE VALUES(7782, 'CLARK',  'MANAGER',   7839, '1981-06-09',  2450, NULL, 10);
INSERT INTO sample.EMPLOYEE VALUES(7934, 'MILLER', 'CLERK',     7782, '1982-01-23', 1300, NULL, 10);
 
INSERT INTO sample.SALARYGRADE VALUES (1,  700, 1200);
INSERT INTO sample.SALARYGRADE VALUES (2, 1201, 1400);
INSERT INTO sample.SALARYGRADE VALUES (3, 1401, 2000);
INSERT INTO sample.SALARYGRADE VALUES (4, 2001, 3000);
INSERT INTO sample.SALARYGRADE VALUES (5, 3001, 9999);
 
INSERT INTO sample.ROLE VALUES (100, 'Developer');
INSERT INTO sample.ROLE VALUES (101, 'Researcher');
INSERT INTO sample.ROLE VALUES (102, 'Project manager');

INSERT INTO sample.PROJECT VALUES (1001, 'Development of Novel Magnetic Suspension System', '2006-01-01', '2007-08-13');
INSERT INTO sample.PROJECT VALUES (1002, 'Research on thermofluid dynamics in Microdroplets', '2006-08-22', '2007-03-20');
INSERT INTO sample.PROJECT VALUES (1003, 'Foundation of Quantum Technology', '2007-02-24', '2008-07-31');
INSERT INTO sample.PROJECT VALUES (1004, 'High capacity optical network', '2008-01-01', null);
 
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1001, 7902, '2006-01-01', '2006-12-30', 102);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1001, 7369, '2006-01-01', '2007-08-13', 100);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1001, 7788, '2006-05-15', '2006-11-01', 100);

INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1002, 7876, '2006-08-22', '2007-03-20', 102);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1002, 7782, '2006-08-22', '2007-03-20', 101);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1002, 7934, '2007-01-01', '2007-03-20', 101);

INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1003, 7566, '2007-02-24', '2008-07-31', 102);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1003, 7900, '2007-02-24', '2007-01-31', 101);

INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1004, 7499, '2008-01-01', null, 102);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1004, 7521, '2008-05-01', null, 101);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1004, 7654, '2008-04-15', null, 101);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1004, 7844, '2008-02-01', null, 101);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1004, 7900, '2008-03-01', '2008-04-01', 101);
INSERT INTO sample.PROJECT_PARTICIPATION VALUES (1004, 7900, '2008-05-20', null, 101);

