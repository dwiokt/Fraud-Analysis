-- show all the data in the table for starter --
select *
from fraud_analysis;

-- renaming any error in column names (if any) after importing data --
alter table fraud_analysis
rename column ï»¿Area_Code to Area_Code;

-- total cases --
select count(*) as "Total_Case_Reported"
from fraud_analysis;

-- fraud confirmed -- 
select 
  Total_Fraud_Confirmed * 100.0 / Total_Case_Reported as "Fraud_Rate_Percentage"
from (
  select
    count(*) as Total_Case_Reported,
    sum(case when Final_Resolution = 'Fraud Confirmed' then 1 else 0 end) as Total_Fraud_Confirmed
  from fraud_analysis
) t;

-- avg resolution time --
select 
	avg(Resolution_Time_Days)
from fraud_analysis;

-- branch & employee affected --
select 
	count(distinct branch_name) as branch_affected, 
	count(distinct employee_id) as employee_affected
from fraud_analysis
where final_resolution="Fraud Confirmed";

-- top 2 employee with most fraud confirmed --
select employee_name, 
	employee_id, 
    branch_name,
    sum(case when Final_Resolution = 'Fraud Confirmed' then 1 else 0 end) as Total_Fraud_Confirmed
from fraud_analysis
group by employee_name, employee_id, branch_name
order by Total_Fraud_Confirmed DESC
limit 2;

-- fraud confirmed per year --
select 
	substr(delivered_date, 7, 4) as year_dlv,
	count(*) as total_fraud_cases
from fraud_analysis
where Final_Resolution="Fraud Confirmed"
group by year_dlv
order by year_dlv;

