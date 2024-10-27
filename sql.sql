Step 1: Create the Database

CREATE DATABASE OnlineLMS;
USE OnlineLMS;

Step 2: Create Tables

1. Create a Users Table

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(50), -- In a real system, store hashed passwords
    email VARCHAR(100),
    user_type ENUM('student', 'instructor'),
    registration_date DATE
);

2. Create a Courses Table

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    description TEXT,
    instructor_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (instructor_id) REFERENCES users(user_id) ON DELETE SET NULL
);

3. Create an Enrollments Table

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    FOREIGN KEY (student_id) REFERENCES users(user_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

4. Create an Assessments Table

CREATE TABLE assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    assessment_name VARCHAR(100),
    total_marks INT,
    due_date DATE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

5. Create a Grades Table

CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    assessment_id INT,
    obtained_marks INT,
    FOREIGN KEY (student_id) REFERENCES users(user_id),
    FOREIGN KEY (assessment_id) REFERENCES assessments(assessment_id)
);

Step 3: Insert Sample Data

1. Insert Users

INSERT INTO users (username, password, email, user_type, registration_date) VALUES
('john_doe', 'password1', 'john@example.com', 'student', '2024-01-01'),
('jane_smith', 'password2', 'jane@example.com', 'student', '2024-01-02'),
('prof_jones', 'password3', 'prof.jones@example.com', 'instructor', '2024-01-03');

2. Insert Courses

INSERT INTO courses (course_name, description, instructor_id, start_date, end_date) VALUES
('Introduction to SQL', 'Learn the basics of SQL for database management.', 3, '2024-01-10', '2024-02-10'),
('Web Development Fundamentals', 'An overview of HTML, CSS, and JavaScript.', 3, '2024-02-15', '2024-03-15');

3. Insert Enrollments

INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-05'),
(1, 2, '2024-01-06'),
(2, 1, '2024-01-07');

4. Insert Assessments

INSERT INTO assessments (course_id, assessment_name, total_marks, due_date) VALUES
(1, 'SQL Basics Quiz', 100, '2024-01-15'),
(2, 'Web Development Project', 200, '2024-03-01');

5. Insert Grades

INSERT INTO grades (student_id, assessment_id, obtained_marks) VALUES
(1, 1, 85),
(2, 1, 90),
(1, 2, 150);

Step 4: Query the Database

1. Select All Users

SELECT * FROM users;

2. Get All Courses with Instructors

SELECT c.course_name, u.username AS instructor_name
FROM courses c
JOIN users u ON c.instructor_id = u.user_id;

3. Get All Enrollments for a Specific Course

SELECT u.username, e.enrollment_date
FROM enrollments e
JOIN users u ON e.student_id = u.user_id
WHERE e.course_id = 1; -- For "Introduction to SQL"

4. Get Assessments for a Specific Course

SELECT a.assessment_name, a.due_date, a.total_marks
FROM assessments a
WHERE a.course_id = 1; -- For "Introduction to SQL"

5. Get Grades for a Student

SELECT a.assessment_name, g.obtained_marks
FROM grades g
JOIN assessments a ON g.assessment_id = a.assessment_id
WHERE g.student_id = 1; -- For student "john_doe"


