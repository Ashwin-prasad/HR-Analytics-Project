SELECT * FROM HR_1;
SELECT * FROM HR_2;
-- KPI 1 Average Attrition rate for all Departments

ALTER TABLE hr_1
ADD attritionrate int;
set sql_safe_updates=0;
update hr_1 set attritionrate= case
when attrition="yes" then 1 else 0 end;

SELECT DISTINCT(DEPARTMENT) FROM HR_1;
SELECT DEPARTMENT,CONCAT(round((avg(ATTRITIONrate)*100),2),' %') AS ATTRITION_RATE FROM hr_1 GROUP BY DEPARTMENT;
-- case 
SELECT DEPARTMENT,CONCAT(round((avg(ATTRITION_R.ATTRITION_Y)*100),2),' %') AS ATTRITION_RATE FROM (select department,attrition,
case when attrition='Yes'
then 1
Else 0
End as attrition_y from hr_1 ) AS ATTRITION_R GROUP BY DEPARTMENT;
-- if condition
SELECT DEPARTMENT,CONCAT(round((avg(ATTRITION_R.ATTRITION_Y)*100),2),' %') AS ATTRITION_RATE FROM (select department,attrition,
IF (ATTRITION ="Yes" , 1 , 0)
 as attrition_y from hr_1 ) AS ATTRITION_R GROUP BY DEPARTMENT;

-- KPI 2 Average Hourly rate of Male Research Scientist

SELECT JOBROLE,ROUND(AVG(HOURLYRATE),2) FROM hr_1 WHERE GENDER="MALE" AND JOBROLE="RESEARCH SCIENTIST" GROUP BY JOBROLE,GENDER;
-- KPI 3  AttritionRate VS MonthlyIncomeStats against department
SELECT DEPARTMENT,CONCAT(round((avg(A.ATTRITION_Y)*100),2),' %') AS ATTRITION_RATE,round(AVG(B.monthlyincome),2) as Average_monthly_Income FROM (select department,attrition,employeeNumber,

IF (ATTRITION ="Yes" , 1 , 0)
 as attrition_y from hr_1 ) AS A join hr_2 as b on B.`Employee ID`=A.EmployeeNumber GROUP BY DEPARTMENT;
                         -- or
SELECT DEPARTMENT,CONCAT(round((avg(A.ATTRITIONrate)*100),2),' %') AS ATTRITION_RATE,round(AVG(B.monthlyincome),2) as Average_monthly_Income FROM  hr_1  AS A join hr_2 as b on B.`Employee ID`=A.EmployeeNumber GROUP BY DEPARTMENT;
                         
-- KPI 4 Average working years for each Department

SELECT A.DEPARTMENT,ROUND(AVG(B.yearsatcompany),2) AS "AVERAGE WORKING YEARS" FROM HR_1 AS A JOIN hr_2 AS B ON B.`Employee ID`=A.EmployeeNumber group by A.department;


-- KPI 5
SELECT JOBROLE,COUNT(`Employee ID`) AS TOTAL_EMPLOYEE,ROUND(AVG(WORKLIFEBALANCE),2)FROM HR_1 AS A join HR_2 AS B ON  B.`Employee ID`=A.EmployeeNumber GROUP BY JOBROLE;
-- OR
select a.JobRole,
sum(case when performancerating = 1 then 1 else 0 end) as 1st_Rating_Total,
sum(case when performancerating = 2 then 1 else 0 end) as 2nd_Rating_Total,
sum(case when performancerating = 3 then 1 else 0 end) as 3rd_Rating_Total,
sum(case when performancerating = 4 then 1 else 0 end) as 4th_Rating_Total, 
count(b.performancerating) as Total_Employee, format(avg(b.WorkLifeBalance),2) as Average_WorkLifeBalance_Rating
from hr_1 as a
inner join hr_2 as b on b.`Employee ID` = a.Employeenumber
group by a.jobrole;

-- KPI 6
SELECT DEPARTMENT,CONCAT(round((avg(A.ATTRITION_Y)*100),2),' %') AS ATTRITION_RATE,round(AVG(B.YearsSinceLastPromotion),2) as Avg_year_since_lastPromotion FROM (select department,attrition,employeeNumber,
IF (ATTRITION ="Yes" , 1 , 0)
 as attrition_y from hr_1 ) AS A join hr_2 as b on B.`Employee ID`=A.EmployeeNumber GROUP BY DEPARTMENT;
                        -- or
SELECT DEPARTMENT,CONCAT(round((avg(A.ATTRITIONrate)*100),2),' %') AS ATTRITION_RATE,round(AVG(B.YearsSinceLastPromotion),2) as Avg_year_since_lastPromotion FROM 
  hr_1  AS A join hr_2 as b on B.`Employee ID`=A.EmployeeNumber GROUP BY DEPARTMENT;                        

