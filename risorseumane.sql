-- Active: 1769426276789@@127.0.0.1@3306@risorseumane
-- Active: 1768984141257@@127.0.0.1@3306@risorseumaneeumane
-- ============================================
-- DUMP COMPLETO DATABASE risorseUmane (OTTIMIZZATO)
-- ============================================

CREATE DATABASE IF NOT EXISTS risorseUmane;
USE risorseUmane;

-- ============================================
-- Tabella REGIONS
-- ============================================
CREATE TABLE regions (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    region_name VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

INSERT INTO regions(ID, region_name) VALUES
(1,'Europe'),
(2,'Americas'),
(3,'Asia'),
(4,'Middle East and Africa');

-- ============================================
-- Tabella COUNTRIES
-- ============================================
CREATE TABLE countries (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    country_id VARCHAR(2) NOT NULL UNIQUE,
    country_name VARCHAR(50) NOT NULL,
    IDregions INT(5) NOT NULL,
    FOREIGN KEY (IDregions) REFERENCES regions(ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO countries(ID, country_id, country_name, IDregions) VALUES
(1,'AR','Argentina',2), (2,'AU','Australia',3), (3,'BE','Belgium',1),
(4,'BR','Brazil',2), (5,'CA','Canada',2), (6,'CH','Switzerland',1),
(7,'CN','China',3), (8,'DE','Germany',1), (9,'DK','Denmark',1),
(10,'EG','Egypt',4), (11,'FR','France',1), (12,'HK','HongKong',3),
(13,'IL','Israel',4), (14,'IN','India',3), (15,'IT','Italy',1),
(16,'JP','Japan',3), (17,'KW','Kuwait',4), (18,'MX','Mexico',2),
(19,'NG','Nigeria',4), (20,'NL','Netherlands',1), (21,'SG','Singapore',3),
(22,'UK','United Kingdom',1), (23,'US','United States of America',2),
(24,'ZM','Zambia',4), (25,'ZW','Zimbabwe',4);

-- ============================================
-- Tabella LOCATIONS
-- ============================================
CREATE TABLE locations (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    location_id INT(5) NOT NULL UNIQUE,
    street_address VARCHAR(100),
    postal_code VARCHAR(20),
    city VARCHAR(50) NOT NULL,
    state_province VARCHAR(50),
    IDcountries INT(5) NOT NULL,
    FOREIGN KEY (IDcountries) REFERENCES countries(ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO locations(ID, location_id, street_address, postal_code, city, state_province, IDcountries) VALUES
(1,1400,'2014 Jabberwocky Rd','26192','Southlake','Texas',23),
(2,1500,'2011 Interiors Blvd','99236','South San Francisco','California',23),
(3,1700,'2004 Charade Rd','98199','Seattle','Washington',23),
(4,1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario',5),
(5,2400,'8204 Arthur St',NULL,'London',NULL,22),
(6,2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford',22),
(7,2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria',8);

-- ============================================
-- Tabella JOBS
-- ============================================
CREATE TABLE jobs (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    job_title VARCHAR(50) NOT NULL UNIQUE,
    min_salary DECIMAL(10,2) NOT NULL,
    max_salary DECIMAL(10,2) NOT NULL,
    CHECK (min_salary > 0),
    CHECK (max_salary > min_salary)
) ENGINE=InnoDB;

INSERT INTO jobs(ID, job_title, min_salary, max_salary) VALUES
(1,'Public Accountant',4200.00,9000.00), (2,'Accounting Manager',8200.00,16000.00),
(3,'Administration Assistant',3000.00,6000.00), (4,'President',20000.00,40000.00),
(5,'Administration Vice President',15000.00,30000.00), (6,'Accountant',4200.00,9000.00),
(7,'Finance Manager',8200.00,16000.00), (8,'Human Resources Representative',4000.00,9000.00),
(9,'Programmer',4000.00,10000.00), (10,'Marketing Manager',9000.00,15000.00),
(11,'Marketing Representative',4000.00,9000.00), (12,'Public Relations Representative',4500.00,10500.00),
(13,'Purchasing Clerk',2500.00,5500.00), (14,'Purchasing Manager',8000.00,15000.00),
(15,'Sales Manager',10000.00,20000.00), (16,'Sales Representative',6000.00,12000.00),
(17,'Shipping Clerk',2500.00,5500.00), (18,'Stock Clerk',2000.00,5000.00),
(19,'Stock Manager',5500.00,8500.00);

-- ============================================
-- Tabella DEPARTMENTS
-- ============================================
CREATE TABLE departments (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL UNIQUE,
    IDlocations INT(5) NOT NULL,
    FOREIGN KEY (IDlocations) REFERENCES locations(ID) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO departments(ID, department_name, IDlocations) VALUES
(1,'Administration',1), (2,'Marketing',1), (3,'Purchasing',3),
(4,'Human Resources',4), (5,'Shipping',2), (6,'IT',3),
(7,'Public Relations',4), (8,'Sales',1), (9,'Executive',1),
(10,'Finance',1), (11,'Accounting',1);

-- ============================================
-- Tabella EMPLOYEES
-- ============================================
CREATE TABLE employees (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    employee_id INT(5) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    IDjobs INT(5) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    IDmanager INT(5),
    IDdepartments INT(5) NOT NULL,
    FOREIGN KEY (IDjobs) REFERENCES jobs(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (IDmanager) REFERENCES employees(ID) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (IDdepartments) REFERENCES departments(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (salary > 0)
) ENGINE=InnoDB;

INSERT INTO employees(ID, employee_id, first_name, last_name, email, phone_number, hire_date, IDjobs, salary, IDmanager, IDdepartments) VALUES
(1,100,'Steven','King','steven.king@sqltutorial.org','515.123.4567','1987-06-17',4,24000.00,NULL,9),
(2,101,'Neena','Kochhar','neena.kochhar@sqltutorial.org','515.123.4568','1989-09-21',5,17000.00,1,9),
(3,102,'Lex','De Haan','lex.de haan@sqltutorial.org','515.123.4569','1993-01-13',5,17000.00,1,9),
(4,103,'Alexander','Hunold','alexander.hunold@sqltutorial.org','590.423.4567','1990-01-03',9,9000.00,3,6),
(5,104,'Bruce','Ernst','bruce.ernst@sqltutorial.org','590.423.4568','1991-05-21',9,6000.00,4,6),
(6,105,'David','Austin','david.austin@sqltutorial.org','590.423.4569','1997-06-25',9,4800.00,4,6),
(7,106,'Valli','Pataballa','valli.pataballa@sqltutorial.org','590.423.4560','1998-02-05',9,4800.00,4,6),
(8,107,'Diana','Lorentz','diana.lorentz@sqltutorial.org','590.423.5567','1999-02-07',9,4200.00,4,6),
(9,108,'Nancy','Greenberg','nancy.greenberg@sqltutorial.org','515.124.4569','1994-08-17',7,12000.00,2,10),
(10,109,'Daniel','Faviet','daniel.faviet@sqltutorial.org','515.124.4169','1994-08-16',6,9000.00,9,10),
(11,110,'John','Chen','john.chen@sqltutorial.org','515.124.4269','1997-09-28',6,8200.00,9,10),
(12,111,'Ismael','Sciarra','ismael.sciarra@sqltutorial.org','515.124.4369','1997-09-30',6,7700.00,9,10),
(13,112,'Jose Manuel','Urman','jose manuel.urman@sqltutorial.org','515.124.4469','1998-03-07',6,7800.00,9,10),
(14,113,'Luis','Popp','luis.popp@sqltutorial.org','515.124.4567','1999-12-07',6,6900.00,9,10),
(15,114,'Den','Raphaely','den.raphaely@sqltutorial.org','515.127.4561','1994-12-07',14,11000.00,1,3),
(16,115,'Alexander','Khoo','alexander.khoo@sqltutorial.org','515.127.4562','1995-05-18',13,3100.00,15,3),
(17,116,'Shelli','Baida','shelli.baida@sqltutorial.org','515.127.4563','1997-12-24',13,2900.00,15,3),
(18,117,'Sigal','Tobias','sigal.tobias@sqltutorial.org','515.127.4564','1997-07-24',13,2800.00,15,3),
(19,118,'Guy','Himuro','guy.himuro@sqltutorial.org','515.127.4565','1998-11-15',13,2600.00,15,3),
(20,119,'Karen','Colmenares','karen.colmenares@sqltutorial.org','515.127.4566','1999-08-10',13,2500.00,15,3),
(21,120,'Matthew','Weiss','matthew.weiss@sqltutorial.org','650.123.1234','1996-07-18',19,8000.00,1,5),
(22,121,'Adam','Fripp','adam.fripp@sqltutorial.org','650.123.2234','1997-04-10',19,8200.00,1,5),
(23,122,'Payam','Kaufling','payam.kaufling@sqltutorial.org','650.123.3234','1995-05-01',19,7900.00,1,5),
(24,123,'Shanta','Vollman','shanta.vollman@sqltutorial.org','650.123.4234','1997-10-10',19,6500.00,1,5),
(25,126,'Irene','Mikkilineni','irene.mikkilineni@sqltutorial.org','650.124.1224','1998-09-28',18,2700.00,21,5),
(26,145,'John','Russell','john.russell@sqltutorial.org',NULL,'1996-10-01',15,14000.00,1,8),
(27,146,'Karen','Partners','karen.partners@sqltutorial.org',NULL,'1997-01-05',15,13500.00,1,8),
(28,176,'Jonathon','Taylor','jonathon.taylor@sqltutorial.org',NULL,'1998-03-24',16,8600.00,1,8),
(29,177,'Jack','Livingston','jack.livingston@sqltutorial.org',NULL,'1998-04-23',16,8400.00,1,8),
(30,178,'Kimberely','Grant','kimberely.grant@sqltutorial.org',NULL,'1999-05-24',16,7000.00,1,8),
(31,179,'Charles','Johnson','charles.johnson@sqltutorial.org',NULL,'2000-01-04',16,6200.00,1,8),
(32,192,'Sarah','Bell','sarah.bell@sqltutorial.org','650.501.1876','1996-02-04',17,4000.00,24,5),
(33,193,'Britney','Everett','britney.everett@sqltutorial.org','650.501.2876','1997-03-03',17,3900.00,24,5),
(34,200,'Jennifer','Whalen','jennifer.whalen@sqltutorial.org','515.123.4444','1987-09-17',3,4400.00,2,1),
(35,201,'Michael','Hartstein','michael.hartstein@sqltutorial.org','515.123.5555','1996-02-17',10,13000.00,1,2),
(36,202,'Pat','Fay','pat.fay@sqltutorial.org','603.123.6666','1997-08-17',11,6000.00,35,2),
(37,203,'Susan','Mavris','susan.mavris@sqltutorial.org','515.123.7777','1994-06-07',8,6500.00,2,4),
(38,204,'Hermann','Baer','hermann.baer@sqltutorial.org','515.123.8888','1994-06-07',12,10000.00,2,7),
(39,205,'Shelley','Higgins','shelley.higgins@sqltutorial.org','515.123.8080','1994-06-07',2,12000.00,2,11),
(40,206,'William','Gietz','william.gietz@sqltutorial.org','515.123.8181','1994-06-07',1,8300.00,39,11);

-- ============================================
-- Tabella JOB_HISTORY
-- ============================================
CREATE TABLE job_history (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    IDemployees INT(5) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    IDjobs INT(5) NOT NULL,
    IDdepartments INT(5) NOT NULL,
    FOREIGN KEY (IDemployees) REFERENCES employees(ID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (IDjobs) REFERENCES jobs(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (IDdepartments) REFERENCES departments(ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (end_date > start_date),
    UNIQUE KEY (IDemployees, start_date)
) ENGINE=InnoDB;

INSERT INTO job_history (ID, IDemployees, start_date, end_date, IDjobs, IDdepartments) VALUES
(1, 3, '1993-01-13', '1998-07-24', 9, 6),
(2, 2, '1989-09-21', '1993-10-27', 6, 11),
(3, 2, '1993-10-28', '1997-03-15', 2, 11),
(4, 35, '1996-02-17', '1999-12-19', 11, 2),
(5, 15, '1998-03-24', '1999-12-31', 18, 5),
(6, 23, '1999-01-01', '1999-12-31', 18, 5),
(7, 34, '1987-09-17', '1993-06-17', 3, 9),
(8, 28, '1998-03-24', '1998-12-31', 16, 8),
(9, 28, '1999-01-01', '1999-12-31', 15, 8),
(10, 34, '1994-07-01', '1998-12-31', 6, 11);

-- ============================================
-- Tabella DEPENDENTS
-- ============================================
CREATE TABLE dependents (
    ID INT(5) AUTO_INCREMENT PRIMARY KEY,
    dependent_id INT(5) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    relationship VARCHAR(20) NOT NULL,
    IDemployees INT(5) NOT NULL,
    FOREIGN KEY (IDemployees) REFERENCES employees(ID) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO dependents(ID, dependent_id, first_name, last_name, relationship, IDemployees) VALUES
(1,1,'Penelope','Gietz','Child',40), (2,2,'Nick','Higgins','Child',39),
(3,3,'Ed','Whalen','Child',34), (4,4,'Jennifer','King','Child',1),
(5,5,'Johnny','Kochhar','Child',2), (6,6,'Bette','De Haan','Child',3),
(7,7,'Grace','Faviet','Child',10), (8,8,'Matthew','Chen','Child',11),
(9,9,'Joe','Sciarra','Child',12), (10,10,'Christian','Urman','Child',13),
(11,11,'Zero','Popp','Child',14), (12,12,'Karl','Greenberg','Child',9),
(13,13,'Uma','Mavris','Child',37), (14,14,'Vivien','Hunold','Child',4),
(15,15,'Cuba','Ernst','Child',5), (16,16,'Fred','Austin','Child',6),
(17,17,'Helen','Pataballa','Child',7), (18,18,'Dan','Lorentz','Child',8),
(19,19,'Bob','Hartstein','Child',35), (20,20,'Lucille','Fay','Child',36),
(21,21,'Kirsten','Baer','Child',38), (22,22,'Elvis','Khoo','Child',16),
(23,23,'Sandra','Baida','Child',17), (24,24,'Cameron','Tobias','Child',18),
(25,25,'Kevin','Himuro','Child',19), (26,26,'Rip','Colmenares','Child',20),
(27,27,'Julia','Raphaely','Child',15), (28,28,'Woody','Russell','Child',26),
(29,29,'Alec','Partners','Child',27), (30,30,'Sandra','Taylor','Child',28);


--1. 1. mostrare per ogni department (basta id), il totale degli employee che ci lavorano, ordinato in modo decrescente
SELECT  d.ID, COUNT(*) AS "n_impiegati"
from departments d, employees e
where d.ID=e.IDdepartments
group by d.ID
order by n_impiegati desc;

--2. mostrare per ogni department, il totale degli employee che ci lavorano, ordinato in modo decrescente
SELECT  d.department_name, COUNT(*) AS "n_impiegati"
from departments d, employees e
where d.ID=e.IDdepartments
group by d.ID
order by n_impiegati desc;
--3. mostrare per ogni department che ha più di 5 employee, il totale degli employee che ci lavorano, ordinato in modo crescente
SELECT d.department_name, COUNT(*) AS "n_impiegati"
FROM departments d, employees e
WHERE d.ID=e.IDdepartments
GROUP BY d.ID 
HAVING n_impiegati > 5
ORDER BY n_impiegati;

--4. mostrare per ogni department, il massimo e il minimo dei salari pagati
SELECT d.department_name, MAX(e.salary) AS "max_Salario", MIN(e.salary) AS "min_Salario"
FROM departments d, employees e
WHERE d.ID=e.IDdepartments
GROUP BY d.ID
ORDER BY max_Salario DESC;

--5. mostrare per ogni department, la somma e la media (arrotondata a 2 cifre) dei salari pagati
SELECT d.department_name, SUM(e.salary) AS "somma", ROUND(AVG(e.salary),2) AS "media"
FROM departments d, employees e
WHERE d.ID=e.IDdepartments
GROUP BY d.ID;
--6. mostrare per ogni manager (basta id) che ne ha più di 4, il numero ordinato decrescente dei suoi sottoposti
SELECT m.first_name ,count(*) as "Sottoposti"
FROM employees e, employees m
WHERE e.ID=m.IDmanager
GROUP BY m.IDmanager
HAVING Sottoposti>4;

--7. mostrare i dipartimenti (basta id) che hanno la somma dei salari compresa tra 20000 e 30000 euro, ordinati in modo crescente
SELECT d.ID, SUM(e.salary) AS "somma_salario"
FROM departments d, employees e
WHERE d.ID=e.IDdepartments
GROUP BY d.ID
HAVING somma_salario BETWEEN 20000 AND 30000
ORDER BY somma_salario ASC;




--8. mostrare i dipartimenti che hanno la media dei salari compresa tra 5000 e 7000 euro, ordinati in modo crescente
SELECT d.department_name,ROUND(AVG(e.salary),2) AS "media_salario"
FROM departments d, employees e
WHERE d.ID=e.IDdepartments
GROUP BY d.ID
HAVING media_salario BETWEEN 5000 AND 7000
ORDER BY media_salario ASC;
--9. mostrare i country che hanno i codici US, UK e CN e le relative locations

SELECT c.country_id, l.location_id
FROM countries c, locations l
WHERE c.id=l.`IDcountries`
AND c.country_id IN ('US','UK','CN');

--10. mostrare, ordinati, i country che  non hanno locations
SELECT c.country_id,l.location_id
FROM countries c left join locations l ON c.ID=l.`IDcountries`
WHERE l.location_id IS NULL
ORDER BY c.country_id;

--10.b mostrare, ordinati, i country che  non hanno country (altro modo)
SELECT c.country_id,c.country_name
FROM countries c RIGHT join locations l ON c.ID=l.`IDcountries`
WHERE c.country_id IS NULL
ORDER BY c.country_id;


--11. mostrare region, country e le relative locations di quei country che hanno i codici IT, DE, CA e relative locations
SELECT r.region_name, c.country_name, l.location_id
FROM regions r, countries c, locations l
WHERE r.ID=c.`IDregions`
AND c.ID=l.`IDcountries`
AND c.country_id IN ('IT','DE','CA');


--12. mostrare per ogni department il totale degli employee che ci lavorano
SELECT d.department_name, COUNT(*) AS "n_impiegati"
FROM departments d, employees e
WHERE d.ID=e.IDdepartments
GROUP BY d.ID;


