The image contains a database management SQL exam with various questions. Let's break down the questions and solve them one by one. I'll also provide the SQL code for each question.

---

### **Part A - Basic SQL (Short Questions)**

#### **1. Create the table `Students` with constraints:**

```sql
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    dob DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);
```

---

#### **2. Insert two new rows into the `Students` table:**

```sql
INSERT INTO Students (student_id, name, email, dob, department_id)
VALUES
(101, 'John Doe', 'john@example.com', '2002-06-15', 2),
(102, 'Jane Smith', 'jane@example.com', '2001-10-30', 1);
```

---

#### **3. Retrieve all students born after 2002, sorted by name in descending order:**

```sql
SELECT * FROM Students
WHERE dob > '2002-01-01'
ORDER BY name DESC;
```

---

#### **4. Display the total number of students in each department:**

```sql
SELECT department_id, COUNT(*) AS total_students
FROM Students
GROUP BY department_id;
```

---

#### **5. Write a query to delete all students from the `Students` table whose dob is before 2000-01-01:**

```sql
DELETE FROM Students
WHERE dob < '2000-01-01';
```

---

### **Part B - Intermediate SQL (JOIN, GROUP BY, Subquery)**

#### **6. Retrieve the name and department\_name of all students:**

```sql
SELECT s.name, d.department_name
FROM Students s
JOIN Departments d ON s.department_id = d.department_id;
```

---

#### **7. Find the average grade of each course. Only show courses with an average grade greater than 3.0:**

```sql
SELECT c.course_name, AVG(e.grade) AS average_grade
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name
HAVING AVG(e.grade) > 3.0;
```

---

#### **8. Write a query to display all students who have not enrolled in any course:**

```sql
SELECT s.name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;
```

---

#### **9. Display the course\_name and the number of students enrolled in each course, ordered from highest to lowest:**

```sql
SELECT c.course_name, COUNT(e.student_id) AS num_enrolled
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY num_enrolled DESC;
```

---

#### **10. List all students whose grade in any course is above the average grade of that course:**

```sql
SELECT s.name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.grade > (
    SELECT AVG(grade)
    FROM Enrollments
    WHERE course_id = c.course_id
);
```

---

### **Final SQL File Creation**

Below is the SQL file with all the above queries.

```sql
-- Part A: Basic SQL

-- 1. Create the Students table with constraints
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    dob DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 2. Insert two new rows into Students
INSERT INTO Students (student_id, name, email, dob, department_id)
VALUES
(101, 'John Doe', 'john@example.com', '2002-06-15', 2),
(102, 'Jane Smith', 'jane@example.com', '2001-10-30', 1);

-- 3. Retrieve all students born after 2002, sorted by name in descending order
SELECT * FROM Students
WHERE dob > '2002-01-01'
ORDER BY name DESC;

-- 4. Display the total number of students in each department
SELECT department_id, COUNT(*) AS total_students
FROM Students
GROUP BY department_id;

-- 5. Delete all students whose dob is before 2000-01-01
DELETE FROM Students
WHERE dob < '2000-01-01';

-- Part B: Intermediate SQL

-- 6. Retrieve the name and department_name of all students
SELECT s.name, d.department_name
FROM Students s
JOIN Departments d ON s.department_id = d.department_id;

-- 7. Find the average grade of each course (greater than 3.0)
SELECT c.course_name, AVG(e.grade) AS average_grade
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
GROUP BY c.course_name
HAVING AVG(e.grade) > 3.0;

-- 8. Display all students who have not enrolled in any course
SELECT s.name
FROM Students s
LEFT JOIN Enrollments e ON s.student_id = e.student_id
WHERE e.student_id IS NULL;

-- 9. Display course_name and number of students enrolled, ordered from highest to lowest
SELECT c.course_name, COUNT(e.student_id) AS num_enrolled
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY num_enrolled DESC;

-- 10. List all students whose grade is above the average grade of that course
SELECT s.name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE e.grade > (
    SELECT AVG(grade)
    FROM Enrollments
    WHERE course_id = c.course_id
);
```

You can save this as an `.sql` file to execute it on your SQL server.

Let me know if you need any further help!
