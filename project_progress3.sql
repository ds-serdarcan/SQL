--Month-Wise Retention Rate
--Find month-by-month customer retention ratei since the start of the business.
--There are many different variations in the calculation of Retention Rate. But we will
--try to calculate the month-wise retention rate in this project.
--So, we will be interested in how many of the customers in the previous month could
--be retained in the next month.
--Proceed step by step by creating “views”. You can use the view you got at the end of
--the Customer Segmentation section as a source.

create view tbl_by_time as
select distinct cust_id, year(order_date) years, month(order_date) months
	, dense_rank() over(order by year(order_date),month(order_date) ) rank_by_time
from combined_table
----order by  rank_by_time
----
declare	 @rank_min int
		,@rank_max int
		,@result decimal(10,2)

select @rank_min = min(rank_by_time) from tbl_by_time
select @rank_max = max(rank_by_time) from tbl_by_time

while @rank_min < @rank_max
begin
	with t1 as(
	select cust_id
	from tbl_by_time
	where	rank_by_time = @rank_min
	intersect 
	select cust_id
	from tbl_by_time
	where	rank_by_time = @rank_min+1
	) 
	select @result = (1.0*count(*)/(select count(*) from tbl_by_time where rank_by_time = @rank_min))
	from t1	
print @result
set @rank_min += 1
end


----------2.Method--------
-----------RESULT TABLE A ATAMA YAPILARAK-------
------------
create table result_table (
	years int,
	months int,
	monthly_rate decimal(10,2)
)
----------
---------
declare	 @rank_min int
		,@rank_max int
		,@result decimal(10,2)

select @rank_min = min(rank_by_time) from tbl_by_time
select @rank_max = max(rank_by_time) from tbl_by_time

while @rank_min < @rank_max
begin
	with t1 as(
	select cust_id
	from tbl_by_time
	where	rank_by_time = @rank_min
	intersect 
	select cust_id
	from tbl_by_time
	where	rank_by_time = @rank_min+1
	) 
	select @result = (1.0*count(*)/(select count(*) from tbl_by_time where rank_by_time = @rank_min))
	from t1	
insert into result_table 
values ( (select distinct years from tbl_by_time where rank_by_time=@rank_min)
		,(select distinct months from tbl_by_time where rank_by_time=@rank_min)
		,@result
		)
set @rank_min += 1
end


-------fonksiyon bitti ve tabloyu yazdýrdýk
select * from result_table




select distinct years from tbl_by_time where rank_by_time=1
select distinct months from tbl_by_time where rank_by_time=1

-------------
------------ ilknur hocanýn çözümü
DECLARE
	@year_min int,
	@year_max int,
	@month_min int,
	@month_max int,
	@result decimal(10,2)

select @year_min = min(years) from time_gap
select @year_max = max(years) from time_gap
select @month_min = min(months) from time_gap
select @month_max = max(months) from time_gap

while @year_min <= @year_max
	begin
		while @month_min < @month_max
			begin
				with tbl as(
					select distinct cust_id
					from time_gap
					where years=@year_min and months=@month_min
					intersect
					select distinct cust_id
					from time_gap
					where years=@year_min and months=@month_min+1
					)
				select @result = (1.0*count(cust_id)/(select count(distinct cust_id) from time_gap where years=@year_min and months=@month_min))
				from tbl;
				PRINT @result
				set @month_min += 1
			end
		PRINT @result
		set @year_min += 1
		select @month_min = min(months) from time_gap
	end




	---------
---------- baþka 
DECLARE
	@year_min int,
	@year_max int,
	@month_min int,
	@month_max int,
	@result decimal(10,2)

select @year_min = min(years) from time_gap
select @year_max = max(years) from time_gap
select @month_min = min(months) from time_gap
select @month_max = max(months) from time_gap

while @year_min <= @year_max
	begin
		while @month_min < @month_max
			begin
				with tbl as(
					select distinct cust_id  -- iki ay üstüste gelen müþteri id lerini bulmak için
					from time_gap
					where years=@year_min and months=@month_min
					INTERSECT
					select distinct cust_id
					from time_gap
					where years=@year_min and months=@month_min+1
					)
				select @result = (1.0 * count(cust_id)/(select count(distinct cust_id) from time_gap where years=@year_min and months=@month_min))
				from tbl
				
				select distinct years,months,@result
				from time_gap
				where years= @year_min and months=@month_min
				set @month_min += 1
			end
		set @year_min += 1
		select @month_min = min(months) from time_gap
		select distinct years,months,@result
		from time_gap
		where years= @year_min and months=@month_min
		
	end;