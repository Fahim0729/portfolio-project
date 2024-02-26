create table users
(id int,
name varchar(50),
phone varchar(50),
role varchar(50),
salary int,
employer_id_fk int
)
insert into Users values
(7856, 'Mr Abul', 02255666777, 'BR', 25000, 5588),
(7654, 'Mr Babul', 01177555666, 'Supervisor', 27500, 6677),
(8768, 'Miss Jorina', 02299000111, 'BR', 40000, 5588),
(5748, 'Mrs Morjina', 01155886644, 'BR', 38000, 5588),
(5748, 'Mrs Morjina', 01155886644, 'BR', 38000, 5588)
select *
from Users
--drop table if exists Users

create table employers 
(id int,
_name varchar(50),
_role varchar(50),
salary int
)
insert into employers values
(5588, 'Mr Rahim', 'Area Coordinator', 50000),
(6677, 'Mr Karim', 'Regional coordinator', 50000)
select *
from Employers
--drop table if exists Employers

     --i) “select count(*) from users”, Write an optimized query against this-___________--------------________________------------_________________-----------
select count(*)
from Users

    --ii) View all users and employers who get maximum salary from each group?__--------------________________------------_________________-----------

select *
from Users
where salary = (select max(salary) from users)

select top 1*                 -- duplicate value_choose 1
from Employers
where salary = (select max(salary) from Employers)
order by id asc               -- if needed then use

   --iii) You want to delete everything of Users, write a query.-------------------________________________________------------------------

delete from users
delete from employers

  --iv)Get the second highest salary from the Users table and which users get them._______--------------------------________________________________-------------------------

SELECT *
FROM users
WHERE salary = (SELECT MAX(salary) 
                 FROM users
                 WHERE salary < (SELECT MAX(salary)
                 FROM users)
                ); 

  --v)How to get distinct records from the Names from users table without using distinct keyword.----------------________________________________-------------------------

SELECT name-- id, phone, role, salary
FROM users
group by name -- id, phone, role, salary   -- ja ja select ta ta group 

  --vi) How to find the count of duplicate rows from a table?---------------------________________________________-------------------------

SELECT id, name, salary, COUNT(*) AS DuplicateCount
FROM users
GROUP BY id, name, salary
HAVING COUNT(*) > 1;

  --vii) Remove duplicates from users but keep one.--------------________________________________-------------------------

WITH CTE AS (
    SELECT id, 
           ROW_NUMBER() OVER (PARTITION BY id ORDER BY (SELECT NULL)) AS RowNum
    FROM users
)
DELETE FROM CTE
WHERE RowNum > 1;

select *
from users
