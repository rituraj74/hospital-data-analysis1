create database Hospitaldb;
USE HospitalDB;

CREATE TABLE Hospital_Data
(
    Hospital_Name VARCHAR(100),
    Location VARCHAR(50),
    Department VARCHAR(50),
    Doctors_Count INT,
    Patients_Count INT,
    Admission_Date DATE,
    Discharge_Date DATE,
    Medical_Expenses DECIMAL(12,2)
);
--1)1. Total Number of Patients
select sum(Patients_Count) as total_patient from Hospital_Data

---2. Average Number of Doctors per Hospital
select Hospital_Name, AVG(Doctors_Count) As avg_doct from Hospital_Data group by Hospital_Name order by Hospital_Name

---Top 3 Departments with the Highest Number of Patients
SELECT TOP 3
    Department,
    SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Patients DESC;

--- Hospital with the Maximum Medical Expenses
select top 1 Hospital_Name , Max(Medical_Expenses) As max_exp from Hospital_Data group  by Hospital_Name order by max_exp desc

--5. Daily Average Medical Expenses
select Admission_Date ,
Avg(Medical_Expenses) as avg_medical_exp 
from Hospital_Data 
group by Admission_Date 
order by avg_medical_exp

SELECT
    Hospital_Name,
    ROUND(
        SUM(Medical_Expenses) /
        NULLIF(
            SUM(DATEDIFF(DAY, Admission_Date, Discharge_Date)),
            0
        ),
        2
    ) AS Avg_Daily_Medical_Expense
FROM Hospital_Data
GROUP BY Hospital_Name
ORDER BY Hospital_Name;

--6. Longest Hospital Stay
select *, DATEDIFF(Day, Admission_Date ,Discharge_Date) As stayed_day
from Hospital_Data order by stayed_day desc

-- 7.Total Patients Treated Per City
select Location , sum(Patients_Count) as total_pat
from Hospital_Data group by Location order by total_pat

--8.Average Length of Stay Per Department
select Department, avg(datediff(day, Admission_Date, Discharge_Date)) As day_stayed 
from Hospital_Data group by Department order by Department

--9.Identify the Department with the Lowest Number of Patients
select top 1 Department, sum(Patients_Count) as patients
from Hospital_Data group by Department order by patients 

--Monthly Medical Expenses Report
SELECT
    YEAR(Admission_Date) AS Admission_Year,
    MONTH(Admission_Date) AS Admission_Month,
    SUM(Medical_Expenses) AS Total_Medical_Expenses
FROM Hospital_Data
GROUP BY
    YEAR(Admission_Date),
    MONTH(Admission_Date)
ORDER BY
    Admission_Year,
    Admission_Month;

select * from Hospital_Data