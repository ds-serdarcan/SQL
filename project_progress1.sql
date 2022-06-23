
---<<<<~~~~~~~~~~~~~1.BÖLÜM~~~~~~~~~~~>>>>--
------Analyze the data by finding the answers to the questions below:------


----<<<<-----QUESTION 1--->>>>----
----create combined table---------

select cd.*,od.*,pd.*,sd.*,mf.[Sales],mf.[Discount],mf.[Order_Quantity],mf.[Product_Base_Margin]
into	combined_table
from	[dbo].[cust_dimen] cd,[dbo].[market_fact] mf,
		[dbo].[orders_dimen] od,[dbo].[prod_dimen] pd,
		[dbo].[shipping_dimen] sd
where	cd.[Cust_id]=mf.Cust_id and od.[Ord_id]=mf.[Ord_id]
		and pd.[Prod_id]=mf.[Prod_id] and sd.[Ship_id]=mf.[Ship_id]



--------- dublicated rows-------
select * from
(
select *,count(*) over(partition by [Ship_id],[Cust_id],[Ord_id],[Prod_id]) count_
from [dbo].[market_fact]
) A
where A.count_>1

----<<<<-----QUESTION 2--->>>>----
----. Find the top 3 customers who have the maximum count of orders.-------
----------1. Method----
select top 3 [Cust_id],[Customer_Name], count(distinct ord_id)  order_counts
from	[dbo].[combined_table]
group by [Cust_id],[Customer_Name]
order by 3 desc

------ 2. Method----
-------WITH CTE---
with t1 as(
select  distinct [Cust_id],[Customer_Name],ord_id
from	[dbo].[combined_table]
)
select distinct top 3 [Cust_id],[Customer_Name], count(ord_id) over(partition by cust_id) count_orders
from t1
order by 3 desc


----<<<<-----QUESTION 3--->>>>----
-------Create a new column at combined_table as DaysTakenForDelivery that--------
-------contains the date difference of Order_Date and Ship_Date.----------
alter table [dbo].[combined_table]
add  DaysTakenForDelivery int
----------
-------
update [dbo].[combined_table]
set  DaysTakenForDelivery =  datediff(d,[Order_Date],[Ship_Date])


----<<<<-----QUESTION 4--->>>>----
----Find the customer whose order took the maximum time to get delivered.------
----1. Method---

select [Cust_id],[Customer_Name],DaysTakenForDelivery  from [dbo].[combined_table]
where DaysTakenForDelivery = (select max(DaysTakenForDelivery) from [dbo].[combined_table])

-----2. method 
------------
select top 1 [Cust_id],[Customer_Name],DaysTakenForDelivery 
from [dbo].[combined_table]
order by DaysTakenForDelivery desc


----<<<<-----QUESTION 5--->>>>----
----Count the total number of unique customers in January and how many of them
----came back every month over the entire year in 2011

select	count(distinct cust_id) unique_customers_Jan_2011
from	[dbo].[combined_table]
where	month(order_date)=1
		and year(order_date)=2011

------------
select	cust_id,count(distinct month(order_date)) count_months
from	[dbo].[combined_table]
where	[Cust_id] in 
		(
		select	distinct cust_id unique_customers_Jan
		from	[dbo].[combined_table]
		where	month(order_date)=1
				and year(order_date)=2011
		)
		and year(order_date)=2011
group by cust_id
--having count(distinct month(order_date))>3
order by 2 desc

---------



------2.method-----
select *
from(
	select distinct Cust_id, month(Order_Date) month_, Ord_id
	from combined_table
	where Cust_id in (
				select distinct Cust_id
				from combined_table
				where year(Order_Date) = 2011 and month(Order_Date) = 1)
			and year(Order_Date) = 2011
	--order by Cust_id, Order_Date
)tbl
pivot(
	count(Ord_id)
	for month_
	in ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])) as pivot_table;


----------------

----<<<<-----QUESTION 6--->>>>----
----Write a query to return for each user the time elapsed between the first
----purchasing and the third purchasing, in ascending order by Customer ID.

with t1 as (
select	distinct cust_id,[Customer_Name],order_date
from	[dbo].[combined_table]
where	cust_id in (
		select cust_id
		from [dbo].[combined_table]
		group by cust_id
		having count(distinct ord_id)>2 
		)
),t2 as(
select *, datediff(d,order_date,lead(order_date,2,order_date) over(partition by cust_id order by order_date)) diff_day
from t1
)
select distinct cust_id,customer_name, first_value(diff_day) over(partition by cust_id order by order_date)diff_day
from t2
order by 1


----<<<<-----QUESTION 7--->>>>----
------Write a query that returns customers who purchased both product 11 and
------product 14, as well as the ratio of these products to the total number of
------products purchased by the  same customers.

with tbl as(
select  [Cust_id],[Prod_id] ,Order_Quantity,sum([Order_Quantity]) over(partition by [Cust_id]) total_q
from [dbo].[combined_table]
where [Cust_id] in	(
		select [Cust_id] from [dbo].[combined_table]
		where prod_id=11
		intersect
		select [Cust_id] from [dbo].[combined_table]
		where prod_id=14 )
)
select distinct [Cust_id], cast(sum([Order_Quantity]) over(partition by [Cust_id])*1.0/total_q as decimal(18,2))  rate
from tbl
where prod_id in (11,14)
order by 1


