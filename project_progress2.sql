---<<<<~~~~~~~~~~~~~2.BÖLÜM~~~~~~~~~~~>>>>--

--Customer Segmentation----
--Categorize customers based on their frequency of visits. The following steps
--will guide you. If you want, you can track your own way.

--1. Create a “view” that keeps logs of customer activities on a --monthly basis. (For
--each log, three field is kept: Cust_id, Year, Month)

select * from [dbo].[combined_table]
------
create view main_t as
select cust_id, year(order_date) years,month(order_date) months,ord_id
from [dbo].[combined_table]
group by cust_id, year(order_date),month(order_date),ord_id
--order by 1,2,3,4

--2. Create a “view” that keeps the number of monthly visits by users. (Show
--separately all months from the beginning business)

create view monthly_visits as

select * from
(
select years,months,ord_id
from main_t
) tbl
PIVOT	(
		count(ord_id)
		for months
		in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
) pvt
--order by 1
	


--3. For each order of customers, create the next month of the order as a separate
--column.

select cust_id,years,months,
		lead(months,1) over(partition by cust_id,years order by months) next_month
from main_t
order by 1,2,3


--4. Calculate the monthly time gap between two consecutive visits by each
--customer.

select cust_id,year(order_date)years,month(order_date)months
		,datediff(month,order_date,lead(order_date,1)over(partition by cust_id order by order_date )) diff_months
from [dbo].[combined_table]
group by cust_id,year(order_date),month(order_date),ord_id,order_date 
order by 1,2,3

--5. Categorise customers using average time gaps. Choose the most fitted
--labeling model for you.
--For example:
--o Labeled as churn if the customer hasn't made another purchase in the
--months since they made their first purchase.
--o Labeled as regular if the customer has made a purchase every month.
--Etc.


with t1 as(
select cust_id,customer_name,year(order_date)years,month(order_date)months,ord_id,order_date 
		,datediff(month,order_date,lead(order_date,1)over(partition by cust_id order by order_date )) diff_months
from [dbo].[combined_table]
group by cust_id,customer_name,year(order_date),month(order_date),ord_id,order_date 

), t2 as(
select*	,avg(diff_months) over (partition by cust_id) avg_order_monthly
		--,avg(diff_months) over () avg_order_date
		,count(*) over(partition by cust_id) total_order_per_cust
from t1
)
select distinct cust_id,customer_name
		,case 
			when avg_order_monthly<5	then  'Loyal' 
			when avg_order_monthly<9	then  'Acceptable'
			else  'Churn' 
		end cust_description
from t2
--where total_order_per_cust>2
order by 1


