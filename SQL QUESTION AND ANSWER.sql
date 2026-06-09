---hr dataset

DROP TABLE IF EXISTS hr;

CREATE TABLE hr(
    Age INT,
    BusinessTravel VARCHAR(100),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education VARCHAR(100),
    EducationField VARCHAR(100),
    EnvironmentSatisfaction VARCHAR(100),
    Gender VARCHAR(100),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction VARCHAR(100),
    MaritalStatus VARCHAR(100),
    Monthly_Income INT,
    Monthly_Rate INT,
    Companies_Worked INT,
    OverTime VARCHAR(100),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction VARCHAR(100),
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance VARCHAR(100),
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,
    Attrition_Numeric VARCHAR(100),
    Seniority_Category VARCHAR(100),
    Monthly_Income_Level VARCHAR(100)
);
select *from hr;
--1 Find the top 10 highest-paying job roles based on maximum salary offered.

SELECT jobrole,
	monthly_income
FROM hr
ORDER BY monthly_income DESC
LIMIT 10;

2--Which department offer the highest average salary across all job postings?

SELECT department,
	avg(monthly_income)as average_income
FROM hr
group by department
ORDER BY average_income DESC;

3--Which job roles have the highest number of employees?

select jobrole,
	count(*) as employee_count
from hr
group by jobrole
order by employee_count desc ;

4--Compare the average monthly income of employees who work overtime and those who do not. 
SELECT overtime,
	round(avg(monthly_income),0)as average_income
FROM hr
group by overtime
ORDER BY average_income DESC;

5--Which department has the highest average monthly income? 

SELECT department,
       ROUND(AVG(monthly_income),0) AS average_income
FROM hr
GROUP BY department
ORDER BY average_income DESC;

6--What is the employee distribution across different education fields? 

SELECT educationfield,
       COUNT(*) AS employee_count
FROM hr
GROUP BY educationfield
ORDER BY employee_count DESC;

7--Which seniority category has the highest average monthly income? 

SELECT seniority_category,
       ROUND(AVG(monthly_income),0) AS average_income
FROM hr
GROUP BY seniority_category
ORDER BY average_income DESC;

8-- Compare attrition rates across departments. 

SELECT department,
       ROUND(AVG(attrition_numeric)*100,2) AS attrition_rate
FROM hr
GROUP BY department
ORDER BY attrition_rate DESC;

9--Which job roles have the highest average total working years? 

SELECT jobrole,
       ROUND(AVG(totalworkingyears),0) AS average_working_years
FROM hr
GROUP BY jobrole
ORDER BY average_working_years DESC;

10--Analyze the relationship between job satisfaction and monthly income.

SELECT jobsatisfaction,
       ROUND(AVG(monthly_income),0) AS average_income
FROM hr
GROUP BY jobsatisfaction
ORDER BY jobsatisfaction;

11--Which employees received the highest percentage salary hike? 

SELECT jobrole,
       percentsalaryhikeb
FROM hr
ORDER BY percentsalaryhikeb DESC
LIMIT 10;

12--Compare average monthly income across different job levels.

SELECT joblevel,
       ROUND(AVG(monthly_income),0) AS average_income
FROM hr
GROUP BY joblevel
ORDER BY joblevel;

13--Rank Employees by Monthly Income Within Each Department

SELECT department,
       jobrole,
       monthly_income,
	   RANK() OVER(PARTITION BY DEPARTMENT ORDER BY MONTHLY_INCOME DESC ) AS SALARY_RANK
FROM HR;

14--Find Employees Earning Above Their Department Average

SELECT department,
       jobrole,
       monthly_income
FROM hr h1
WHERE monthly_income >
(
    SELECT AVG(monthly_income)
    FROM hr h2
	 WHERE h1.department = h2.department

);

15--dentify the Top 3 Highest-Paid Employees in Each Departmen

WITH salary_rank AS
(
    SELECT department,
           jobrole,
           monthly_income,
           ROW_NUMBER() OVER(PARTITION BY department ORDER BY monthly_income DESC) AS rn
    FROM hr
)
SELECT department,
       jobrole,
       monthly_income
FROM salary_rank
WHERE rn <= 3;