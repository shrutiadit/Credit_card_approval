
CREATE DATABASE IF NOT EXISTS credit_card_project;

use  credit_card_project;

# Setting up  for loading the data files
# if the data file is small ,we can use data wizard to import csv data
# The data files almost 20 thousand records, therefore we use the function load infile which loads the csv data into tables in no time.

show variables like 'local_infile';
SET GLOBAL local_infile = true; 

SELECT @@GLOBAL.secure_file_priv;

# create the table  before we load the csv file in the table
create table  applicant_info (
Ind_ID int,
Gender varchar(1),
 Car_owner varchar(1),
 Propert_owner  varchar(1),
 Children int ,
 Annual_income float,
Type_Income varchar(20), 
 Education varchar(20),
Marital_status varchar(20),
Housing_type varchar(20),
Birthday_count int,
Employed_days int,
Mobile_phone int,
Work_phone int,
Phone int,
EMAIL_ID varchar(20),
Type_Occupation varchar(20),
Family_Members int
);



create table credit_card_label(
Ind_ID int,
label int);


# load the data using local infile function

load data local infile 'C:/Users/ADMIN/Desktop/Credit_card.csv'
into table applicant_info
fields terminated by ','
ignore 1 rows;

load data local infile 'C:/Users/ADMIN/Desktop/Credit_card_label.csv'
into table credit_card_label
fields terminated by ','
ignore 1 rows;






select count(*) from applicant_info;

select count(*) from credit_card_label;


# 1) Group the customers based on their income type and find the average of their annual income.

select Type_Income,avg(Annual_income) from applicant_info
group by Type_Income;
        
        
#Find the female owners of cars and property.
select * from applicant_info
where GENDER='F' and Car_Owner='Y' and Propert_Owner='Y';

# Find the male customers who are staying with their families.
select * from applicant_info
where GENDER='M' and Family_Members>1;

# Please list the top five people having the highest income.
select * from applicant_info
order by Annual_income desc
LIMIT 5;

# How many married people are having bad credit?
select count(*) from applicant_info a
join credit_card_label c
on a.Ind_ID=c.Ind_ID
where a.Marital_status like 'Ma%' and c.label=0; 

# What is the highest education level and what is the total count?
select distinct EDUCATION
from applicant_info;

select count(*) from applicant_info
where EDUCATION LIKE 'Academic%';


#Between married males and females, who is having more bad credit? 

select count(a.Ind_ID) as '','' from applicant_info as a 
join
credit_card_label as c 
on a.Ind_ID=c.Ind_ID
where a.GENDER like'M' and a.Marital_status like 'M%' and c.label=0
union
select count(a.Ind_ID) as total_count,'female' from applicant_info as a 
join
credit_card_label as c 
on a.Ind_ID=c.Ind_ID
where a.GENDER like'F' and a.Marital_status like 'M%' and c.label=0
order by 1 desc
limit 1




