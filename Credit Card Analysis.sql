create database credit_card_analysis;
use credit_card_analysis;

create table customers(
Client_Num bigint primary key, 
Customer_Age int,
Gender varchar(50),
Dependent_Count int,
Education_Level varchar(50),
Marital_Status  varchar(50),
state_cd  varchar(50),
Zipcode int,
Car_Owner varchar(50),
House_Owner varchar(50),
Personal_loan  varchar(50),
contact varchar(50),
Customer_Job varchar(50),
Income  int,
Cust_Satisfaction_Score int);


create table credit_card(
Client_Num bigint, 
Card_Category varchar(50), 
Annual_Fees int, 
Activation_30_Days int,
Customer_Acq_Cost int,
Week_Start_Date date, 
Week_Num varchar(50), 
Qtr varchar(50),
current_year int,
Credit_Limit float, 
Total_Revolving_Bal int,
Total_Trans_Amt int, 
Total_Trans_Vol int, 
Avg_Utilization_Ratio float,
`Use Chip` varchar(50),
`Exp Type` varchar(50), 
Interest_Earned float, 
Delinquent_Acc int,
constraint fk_client
foreign key (Client_Num) references customers(Client_Num)
);

-- loading customer data
Set global local_infile=1;

load data local infile "E:/Credit Card Financial Analysis/final_customers.csv"
into table customers
fields terminated by ','
enclosed by '"'
lines terminated by "\n"
ignore 1 rows;

-- loading credit card data
Set global local_infile=1;

load data local infile "E:\Credit Card Financial Analysis/final_credit_card.csv"
into table credit_card
fields terminated by ','
enclosed by '"'
lines terminated by "\n"
ignore 1 rows;

select * from credit_card;

select * from customers;



-- 💰 Revenue & Profitability (Business Growth)

-- 1. A bank wants to measure total earnings — what is the total interest revenue generated?
SELECT round(sum(Interest_Earned), 2) AS Total_Interest_Revenue
FROM credit_card;

-- 2. Management wants to track customer value — what is the average revenue per customer?
select round(avg(interest_earned), 2) as Avg_Revenue_Per_Customer
from credit_card;

-- 3. Which card category contributes the highest revenue for the business?
select card_category,
round(sum(interest_earned), 2) as Total_Revenue
from credit_card
group by card_category
order by Total_Revenue desc;

-- 4. How has revenue changed quarter-over-quarter in the last year?
SELECT Qtr, round(SUM(Interest_Earned), 2) AS revenue
FROM credit_card
GROUP BY qtr
ORDER BY Qtr;

-- 5. Which customer segment (age group) generates the most revenue?
SELECT
  CASE
    WHEN c.Customer_Age < 30 THEN 'Under 30'
    WHEN c.Customer_Age BETWEEN 30 AND 45 THEN '30-45'
    WHEN c.Customer_Age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS Age_Group,
  ROUND(SUM(cc.Interest_Earned), 2) AS Total_Revenue
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY Age_Group
ORDER BY Total_Revenue DESC;

-- 6. Does higher income lead to higher revenue contribution?
SELECT
  CASE
    WHEN c.Income < 40000  THEN 'Low (<40K)'
    WHEN c.Income < 80000  THEN 'Mid (40K-80K)'
    WHEN c.Income < 120000 THEN 'High (80K-120K)'
    ELSE 'Very High (120K+)'
  END AS Income_Band,
  ROUND(AVG(cc.Interest_Earned), 2) AS Avg_Revenue
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY Income_Band
ORDER BY Avg_Revenue DESC;

-- 7. Which states are generating the highest revenue for the bank?
select c.state_cd,
round(sum(cc.interest_earned)) as State_Revenue
from customers as c
join credit_card as cc
on c.Client_Num = cc.Client_Num
group by c.state_cd
order by State_Revenue desc;

-- 8. What percentage of total revenue comes from top 10% customers?
WITH ranked AS (
  SELECT Client_Num,
         SUM(Interest_Earned) AS cust_rev,
         NTILE(10) OVER (ORDER BY SUM(Interest_Earned) DESC) AS decile
  FROM credit_card GROUP BY Client_Num
)
SELECT
  ROUND(SUM(CASE WHEN decile = 1 THEN cust_rev END) /
        SUM(cust_rev) * 100, 2) AS Top10_Pct_Revenue
FROM ranked;


-- 9. Are premium card users contributing more revenue than basic card users?
select card_category,
	   count(distinct client_num) as customers,
       round(sum(interest_earned), 2) as Total_Revenue,
       round(avg(interest_earned), 2) as Avg_Revenue
from credit_card
group by card_category
order by Avg_revenue desc;


-- 10. Which job profile customers are most profitable?
SELECT Customer_Job, round(SUM(Interest_Earned), 2) as Profitable_Customers_by_Profile 
FROM customers c 
JOIN credit_card cc 
ON c.Client_Num = cc.Client_Num 
GROUP BY Customer_Job
ORDER BY  sum(interest_earned) DESC;



-- ---

-- 💳 Customer Activity & Engagement

-- 11. What is the total transaction amount processed by the bank?
SELECT SUM(Total_Trans_Amt) AS Total_Transaction_Amount
FROM credit_card;

-- 12. How many total transactions are performed across all customers?
SELECT SUM(Total_Trans_Vol) AS Total_Transaction_Volume
FROM credit_card;

-- 13. What is the average transaction value per customer?
SELECT Client_Num, round(AVG(Total_Trans_Amt), 2) 
FROM credit_card;

SELECT Client_Num,
       ROUND(SUM(Total_Trans_Amt) / NULLIF(SUM(Total_Trans_Vol), 0), 2)
         AS Avg_Transaction_Value
FROM credit_card
GROUP BY Client_Num
ORDER BY Avg_Transaction_Value DESC;

-- 14. What percentage of customers are actively using their cards?
SELECT 
(COUNT(CASE 
	   WHEN Activation_30_Days = 1 THEN 1 END) * 100.0 / 
       COUNT(*)) as Active_Cards
FROM credit_card;

-- 15. Which customers have stopped making transactions (inactive users)?
SELECT DISTINCT Client_Num
FROM credit_card
WHERE Total_Trans_Vol = 0;


-- 16. What is the average number of transactions per customer?
SELECT ROUND(AVG(Total_Trans_Vol), 2) AS Avg_Transactions_Per_Customer
FROM credit_card;


-- 17. Which segment of customers uses credit cards most frequently?
SELECT c.Customer_Job,
       ROUND(AVG(cc.Total_Trans_Vol), 2) AS Avg_Txn_Volume
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Customer_Job
ORDER BY Avg_Txn_Volume DESC;


-- 18. Are younger customers more active than older ones?
SELECT
  CASE
    WHEN c.Customer_Age < 30 THEN 'Under 30'
    WHEN c.Customer_Age BETWEEN 30 AND 45 THEN '30-45'
    WHEN c.Customer_Age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS Age_Group,
  ROUND(AVG(cc.Total_Trans_Vol), 2) AS Avg_Transactions
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY Age_Group
ORDER BY Avg_Transactions DESC;


-- 19. What is the trend of customer activity over time?
SELECT Week_Num, Qtr, current_year,
       SUM(Total_Trans_Vol) AS Weekly_Transactions,
       SUM(Total_Trans_Amt) AS Weekly_Spend
FROM credit_card
GROUP BY current_year, Qtr, Week_Num
ORDER BY current_year, CAST(Week_Num AS UNSIGNED);


-- 20. Which customers are high-frequency but low-value spenders?
SELECT Client_Num,
       SUM(Total_Trans_Vol) AS Txn_Count,
       SUM(Total_Trans_Amt) AS Total_Spend,
       ROUND(SUM(Total_Trans_Amt) / 
       NULLIF(SUM(Total_Trans_Vol),0),2) AS Avg_Txn_Value
FROM credit_card
GROUP BY Client_Num
HAVING Txn_Count > (SELECT AVG(Total_Trans_Vol) FROM credit_card)
   AND Avg_Txn_Value < (SELECT AVG(Total_Trans_Amt/NULLIF(Total_Trans_Vol,0)) FROM credit_card)
ORDER BY Txn_Count DESC;


-- ---

-- 📉 Risk & Credit Management

-- 21. What is the overall delinquency rate of customers?
SELECT
  ROUND(SUM(Delinquent_Acc) * 100.0 / COUNT(*), 2) AS Delinquency_Rate_Pct
FROM credit_card;


-- 22. Which segment of customers has the highest delinquency rate?
SELECT c.Customer_Job,
       ROUND(AVG(cc.Delinquent_Acc) * 100, 2) AS Delinquency_Rate_Pct
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Customer_Job
ORDER BY Delinquency_Rate_Pct DESC;


-- 23. What percentage of customers are classified as high-risk?
SELECT
  ROUND(COUNT(CASE WHEN Avg_Utilization_Ratio > 0.75
                    AND Delinquent_Acc > 0 THEN 1 END) * 100.0 /
        COUNT(*), 2) AS High_Risk_Pct
FROM credit_card;


-- 24. Do customers with high utilization ratios default more often?
SELECT
  CASE
    WHEN Avg_Utilization_Ratio < 0.3  THEN 'Low (<30%)'
    WHEN Avg_Utilization_Ratio < 0.6  THEN 'Medium (30-60%)'
    WHEN Avg_Utilization_Ratio < 0.9  THEN 'High (60-90%)'
    ELSE 'Very High (90%+)'
  END AS Utilization_Band,
  ROUND(AVG(Delinquent_Acc) * 100, 2) AS Delinquency_Rate_Pct,
  count(*) as Total_Delinquent
FROM credit_card
GROUP BY Utilization_Band
ORDER BY Delinquency_Rate_Pct DESC;


-- 25. Which income group has the highest credit risk?
SELECT
  CASE
    WHEN c.Income < 40000  THEN 'Low (<40K)'
    WHEN c.Income < 80000  THEN 'Mid (40K-80K)'
    ELSE 'High (80K+)'
  END AS Income_Band,
  ROUND(AVG(cc.Delinquent_Acc) * 100, 2) AS Delinquency_Rate_Pct
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY Income_Band
ORDER BY Delinquency_Rate_Pct DESC;


-- 26. What is the average credit utilization ratio across customers?
SELECT ROUND(AVG(Avg_Utilization_Ratio) * 100, 2) AS Avg_Utilization_Pct
FROM credit_card;


-- 27. Which customers are close to exceeding their credit limits?
SELECT Client_Num,
       Credit_Limit,
       Total_Revolving_Bal,
       ROUND(Total_Revolving_Bal / NULLIF(Credit_Limit, 0) * 100, 2) AS Utilization_Pct
FROM credit_card
WHERE Total_Revolving_Bal / NULLIF(Credit_Limit, 0) > 0.9
ORDER BY Utilization_Pct DESC;

-- 28. Are customers with low satisfaction more likely to default?
SELECT c.Cust_Satisfaction_Score,
       ROUND(AVG(cc.Delinquent_Acc) * 100, 2) AS Delinquency_Rate_Pct,
       COUNT(*) AS Customer_Count
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Cust_Satisfaction_Score
ORDER BY c.Cust_Satisfaction_Score;

-- 29. What is the relationship between credit limit and delinquency?
SELECT
  CASE
    WHEN Credit_Limit < 5000   THEN 'Under 5K'
    WHEN Credit_Limit < 10000  THEN '5K-10K'
    WHEN Credit_Limit < 20000  THEN '10K-20K'
    ELSE 'Above 20K'
  END AS Limit_Band,
  ROUND(AVG(Delinquent_Acc) * 100, 2) AS Delinquency_Rate_Pct
FROM credit_card
GROUP BY Limit_Band
ORDER BY Delinquency_Rate_Pct DESC;

-- 30. Which states have the highest number of delinquent accounts?
SELECT c.state_cd,
       SUM(cc.Delinquent_Acc) AS Total_Delinquent,
       COUNT(*)               AS Total_Accounts,
       ROUND(SUM(cc.Delinquent_Acc) * 100.0 / COUNT(*), 2) AS Delinquency_Pct
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.state_cd
ORDER BY Total_Delinquent DESC;



-- ---

-- 👥 Customer Segmentation & Profiling

-- 31. How many customers fall into each age group category?
SELECT
  CASE
    WHEN Customer_Age < 30 THEN 'Under 30'
    WHEN Customer_Age BETWEEN 30 AND 45 THEN '30-45'
    WHEN Customer_Age BETWEEN 46 AND 60 THEN '46-60'
    ELSE '60+'
  END AS Age_Group,
  COUNT(*) AS Customer_Count
FROM customers
GROUP BY Age_Group
ORDER BY Customer_Count DESC;

-- 32. What is the distribution of customers by income group?
SELECT
  CASE
    WHEN Income < 40000  THEN 'Low (<40K)'
    WHEN Income < 80000  THEN 'Mid (40K-80K)'
    WHEN Income < 120000 THEN 'High (80K-120K)'
    ELSE 'Very High (120K+)'
  END AS Income_Group,
  COUNT(*) AS Customers
FROM customers
GROUP BY Income_Group
ORDER BY Customers DESC;

-- 33. Which education level group contributes most to revenue?
SELECT c.Education_Level,
       ROUND(SUM(cc.Interest_Earned), 2) AS Total_Revenue,
       COUNT(DISTINCT c.Client_Num)      AS Customers
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Education_Level
ORDER BY Total_Revenue DESC;

-- 34. What is the customer distribution by marital status?
SELECT Marital_Status,
       COUNT(*) AS Customer_Count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Pct
FROM customers
GROUP BY Marital_Status
ORDER BY Customer_Count DESC;

-- 35. Which demographic segment is most profitable?
SELECT c.Gender, c.Education_Level,
       ROUND(AVG(cc.Interest_Earned), 2) AS Avg_Revenue,
       COUNT(DISTINCT c.Client_Num)      AS Customers
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Gender, c.Education_Level
ORDER BY Avg_Revenue DESC;

-- 36. Do homeowners spend more than non-homeowners?
SELECT c.House_Owner,
       ROUND(AVG(cc.Total_Trans_Amt), 2) AS Avg_Spend,
       COUNT(DISTINCT c.Client_Num)      AS Customers
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.House_Owner
ORDER BY Avg_Spend DESC;

-- 37. Are car owners more active in transactions?
SELECT c.Car_Owner,
       ROUND(AVG(cc.Total_Trans_Vol), 2) AS Avg_Txn_Volume,
       ROUND(AVG(cc.Total_Trans_Amt), 2) AS Avg_Spend
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Car_Owner;

-- 38. Which job category has the highest average transaction value?
SELECT c.Customer_Job,
       ROUND(AVG(cc.Total_Trans_Amt / NULLIF(cc.Total_Trans_Vol, 0)), 2)
         AS Avg_Txn_Value
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Customer_Job
ORDER BY Avg_Txn_Value DESC;

-- 39. What is the gender-wise distribution of customers?
SELECT Gender,
       COUNT(*) AS Customer_Count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Pct
FROM customers
GROUP BY Gender;

-- 40. Which segment shows the highest customer satisfaction?
SELECT c.Customer_Job,
       ROUND(AVG(c.Cust_Satisfaction_Score), 2) AS Avg_Satisfaction
FROM customers c
GROUP BY c.Customer_Job
ORDER BY Avg_Satisfaction DESC;



-- ---

-- 🛍️ Spending Behavior Analysis

-- 41. Which expense type contributes the highest spending?
SELECT `Exp Type`,
       SUM(Total_Trans_Amt) AS Total_Spend
FROM credit_card
GROUP BY `Exp Type`
ORDER BY Total_Spend DESC;

-- 42. What is the spending pattern across different customer segments?
SELECT c.Customer_Job, cc.`Exp Type`,
       ROUND(SUM(cc.Total_Trans_Amt), 2) AS Total_Spend
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Customer_Job, cc.`Exp Type`
ORDER BY c.Customer_Job, Total_Spend DESC;

-- 43. Do high-income customers spend more on specific categories?
SELECT cc.`Exp Type`,
       ROUND(SUM(cc.Total_Trans_Amt), 2) AS Total_Spend
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
WHERE c.Income > 100000
GROUP BY cc.`Exp Type`
ORDER BY Total_Spend DESC;

-- 44. What is the average spending per transaction by expense type?
SELECT `Exp Type`,
       ROUND(SUM(Total_Trans_Amt) / NULLIF(SUM(Total_Trans_Vol), 0), 2)
         AS Avg_Spend_Per_Txn
FROM credit_card
GROUP BY `Exp Type`
ORDER BY Avg_Spend_Per_Txn DESC;

-- 45. Which customers have unusually high spending patterns?
SELECT Client_Num,
       SUM(Total_Trans_Amt) AS Total_Spend
FROM credit_card
GROUP BY Client_Num
HAVING Total_Spend > (
  SELECT AVG(Total_Spend) + 2 * STDDEV(Total_Spend)
  FROM (SELECT Client_Num, SUM(Total_Trans_Amt) AS Total_Spend
        FROM credit_card GROUP BY Client_Num) t
)
ORDER BY Total_Spend DESC;

-- 46. What is the trend of spending over time?
SELECT Week_Num, current_year, Qtr,
       SUM(Total_Trans_Amt) AS Weekly_Spend,
       ROUND(AVG(SUM(Total_Trans_Amt))
             OVER (ORDER BY current_year, CAST(Week_Num AS UNSIGNED)
                   ROWS BETWEEN 3 PRECEDING AND CURRENT ROW), 2)
         AS Moving_Avg_4W
FROM credit_card
GROUP BY current_year, Qtr, Week_Num
ORDER BY current_year, CAST(Week_Num AS UNSIGNED);

-- 47. Do customers prefer chip-based transactions over others?
SELECT `Use Chip`,
       COUNT(*)                AS Transactions,
       SUM(Total_Trans_Amt)    AS Total_Spend,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS Share_Pct
FROM credit_card
GROUP BY `Use Chip`
ORDER BY Transactions DESC;

-- 48. What is the adoption rate of chip usage among customers?
SELECT
  ROUND(COUNT(CASE WHEN `Use Chip` = 'Chip Transaction' THEN 1 END)
        * 100.0 / COUNT(*), 2) AS Chip_Adoption_Pct
FROM credit_card;

-- 49. Which segment prefers digital vs physical transactions?
SELECT c.Customer_Job,
       cc.`Use Chip`    AS Transaction_Type,
       COUNT(*)           AS Count
FROM customers c
JOIN credit_card cc ON c.Client_Num = cc.Client_Num
GROUP BY c.Customer_Job, cc.`Use Chip`
ORDER BY c.Customer_Job, Count DESC;

-- 50. Are customers shifting their spending behavior over time?
SELECT current_year, Qtr, `Exp Type`,
       ROUND(SUM(Total_Trans_Amt), 2) AS Quarterly_Spend
FROM credit_card
GROUP BY current_year, Qtr, `Exp Type`
ORDER BY current_year, Qtr, Quarterly_Spend DESC;


-- Here's your full SQL KPI reference bank! Here's what's included:
-- 5 categories, 50 KPIs:

-- Revenue & Profitability (Q1–10) — interest revenue, QoQ growth, top-10% Pareto, profitability by job/state
-- Activity & Engagement (Q11–20) — transaction volume/value, active vs dormant users, high-frequency low-value spenders
-- Risk & Credit (Q21–30) — delinquency rates, utilization-to-default correlation, near-limit accounts, state-wise risk
-- Segmentation (Q31–40) — age/income/education/marital distributions, homeowner vs non-homeowner spend
-- Spending Behavior (Q41–50) — expense type breakdown, chip adoption, 4-week moving average, behavioral shift over time