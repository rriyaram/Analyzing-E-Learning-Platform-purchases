# Analyzing-E-Learning-Platform-purchases
  Analyze purchase data to understand sales trends, learner behavior, and popular course categories.
 Database Overview

The database consists of three tables:

1️⃣ Students Table

Stores student personal details.

student_id – Primary Key

student_name

age

city

2️⃣ Courses Table

Stores course-related details.

course_id – Primary Key

course_name

category

fee

3️⃣ Enrollments Table

Stores which student enrolled in which course.

enrollment_id – Primary Key

student_id – Foreign Key → Students

course_id – Foreign Key → Courses

enrollment_date

🛠️ How to Use

1️⃣ Open MySQL, SQL Server, Oracle, or any SQL tool
2️⃣ Create a new database
3️⃣ Run the script file:

sql module end assignment.sql


This will:
✔️ Create database
✔️ Create tables
✔️ Insert sample records

✅ Sample Features You Can Practice

You can try SQL queries like:

List all students

List courses and fees

Show enrolled students with course names

Find students by city

Check highest or lowest course fee

📌 Purpose

This assignment helps in understanding:

Database creation

Table relationships

Primary & Foreign Keys

Data insertion

Basic query practice

👩‍💻 Author

Padma Priya
