create database if not exists studentsDB;
use studentsDB;
create table if not exists  learners(
	learner_id int Primary Key,
	full_name varchar(25),
	Country varchar(30));
create table if not exists courses(
    course_id int  Primary Key,
	course_name varchar(40),
	category varchar(50), 
	unit_price int );
create table if not exists purchases(
 	purchase_id int Primary key,
    learner_id int ,
    course_id int ,
    Quantity int,
    Purchase_date date,
	Foreign Key  (learner_id ) REFERENCES learners(learner_id),
    Foreign Key  (course_id) references courses(course_id));
    insert into learners(learner_id ,full_name,country) values
    (1, 'Aarav Patel', 'India'),
(2, 'Fatima Ali', 'UAE'),
    (3, 'John Smith', 'USA'),
(4, 'Maria Garcia', 'Spain'),
(5, 'Ahmed Hassan', 'Egypt'),
(6, 'Sophia Lee', 'South Korea');
INSERT INTO courses (course_id, course_name, category, unit_price) VALUES
(101, 'Data Analytics', 'Data', 1200),
(102, 'Python Programming', 'Programming', 900),
(103, 'Machine Learning', 'AI', 1500),
(104, 'SQL for Beginners', 'Database', 700),
(105, 'Business Intelligence', 'Data', 1100),
(106, 'Cloud Computing', 'IT', 1300);
INSERT INTO purchases (purchase_id, learner_id, course_id, quantity, purchase_date) VALUES
(1001, 1, 101, 1, '2024-01-10'),
(1002, 1, 102, 1, '2024-01-18'),
(1003, 1, 104, 2, '2024-02-05'),
(1004, 2, 103, 1, '2024-02-10'),
(1005, 3, 101, 1, '2024-02-20'),
(1006, 4, 105, 2, '2024-03-01'),
(1007, 4, 101, 1, '2024-02-10'),
(1008, 4, 103, 1, '2024-02-18'),
(1009, 5, 106, 1, '2024-03-12'),
(1010, 6, 104, 1, '2024-03-25');
select * from learners ;
select * from courses;
select * from purchases;

/* Display each learner’s total spending */
create view learnersspending as 
  select l.learner_id,
  l.country,l.full_name,
  sum(p.quantity * c.unit_price) as total_spent 
  from purchases p join courses c on p.course_id=c.course_id
join learners l on p.learner_id=l.learner_id
 group by l.learner_id,l.country,l.full_name 
order by total_spent desc;
select * from learnersspending;


/* top 3 most purchased courses */
select c.course_id,c.course_name,
count(p.quantity) as topmost_courses from purchases p
 join courses c  on p.course_id=c.course_id 
 group by c.course_id
 order by topmost_courses desc limit 3;
 
/*  each course category’s total revenue and the number of unique learners who purchased from that category */
 
SELECT 
    c.category,
    SUM(p.quantity * c.unit_price) AS total_revenue,
    COUNT(DISTINCT p.learner_id) AS unique_learners
FROM purchases p
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.category
ORDER BY total_revenue DESC;

/* learners who have purchased more than one course */
select learner_id,count(quantity)  as purchased_quantity from purchases group by learner_id having purchased_quantity>1;


/* courses that have not been purchased at all */
select p.purchase_id,c.course_name,c.course_id  from courses c left join purchases p on p.course_id=c.course_id;

/* list full_name with their course*/

DELIMITER $$

CREATE PROCEDURE get_learner_courses(IN p_learner_id INT)
BEGIN
    SELECT 
        l.full_name,
        c.course_name
    FROM purchases p
    JOIN learners l ON p.learner_id = l.learner_id
    JOIN courses c ON p.course_id = c.course_id
    WHERE p.learner_id = p_learner_id;
END $$

DELIMITER ;
CALL get_learner_courses(1);

/* total spending of learner */
DELIMITER $$

CREATE FUNCTION get_total_spending(p_learner_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(p.quantity * c.unit_price)
    INTO total
    FROM purchases p
    JOIN courses c ON p.course_id = c.course_id
    WHERE p.learner_id = p_learner_id;

    RETURN IFNULL(total, 0);
END $$

DELIMITER ;
SELECT 
    l.full_name,
    get_total_spending(l.learner_id) AS total_spending
FROM learners l;



/* learners country */

DELIMITER $$

CREATE FUNCTION get_learner_country(p_learner_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE ctry VARCHAR(50);

    SELECT country
    INTO ctry
    FROM learners
    WHERE learner_id = p_learner_id;

    RETURN ctry;
END $$

DELIMITER ; 
select l.full_name,get_learner_country(l.learner_id) as learner_country from learners l;







	



