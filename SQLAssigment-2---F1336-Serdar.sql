---- Kýsa Çözüm----
----main tablosu
select distinct so.[customer_id],[first_name],[last_name],pp.[product_name]
into #Main_Tab
from [product].[product] 		pp
	join [sale].[order_item] 	soi		on pp.[product_id] = soi.[product_id]
	join [sale].[orders] 		so		on so.[order_id] = soi.[order_id]
	join [sale].[customer]		sc		on so.[customer_id] = sc.[customer_id]
---sonuç---
select  customer_id,first_name,last_name 
		,IIF(sum(IIF(product_name = 'Polk Audio - 50 W Woofer - Black',1,0))=1,'Yes','No') as First_
		,IIF(sum(IIF(product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)',1,0))=1,'Yes','No') as Second_
		,IIF(sum(IIF(product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)',1,0))=1,'Yes','No') as Third_
from #Main_Tab
where customer_id in (select customer_id from #Main_Tab 
						where product_name like '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD' )
group by customer_id,first_name,last_name 
order by customer_id



------ uzun çözüm------
----- main tablosu--------

select distinct so.[customer_id],[first_name],[last_name],pp.[product_name]
into #Main_Table
from [product].[product] 		pp
	join [sale].[order_item] 	soi		on pp.[product_id] = soi.[product_id]
	join [sale].[orders] 		so		on so.[order_id] = soi.[order_id]
	join [sale].[customer]		sc		on so.[customer_id] = sc.[customer_id]
	and [product_name] like '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'
---where [product_name] like '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD'


----- first product --------
select distinct so.[customer_id],[first_name],[last_name],pp.[product_name]
into #first_ta
from [product].[product] 		pp
	join [sale].[order_item] 	soi		on pp.[product_id] = soi.[product_id]
	join [sale].[orders] 		so		on so.[order_id] = soi.[order_id]
	join [sale].[customer]		sc		on so.[customer_id] = sc.[customer_id]
	and [product_name] like 'Polk Audio - 50 W Woofer - Black'

----- second tablosu--------
select distinct so.[customer_id],[first_name],[last_name],pp.[product_name]
into #second_ta
from [product].[product] 		pp
	join [sale].[order_item] 	soi		on pp.[product_id] = soi.[product_id]
	join [sale].[orders] 		so		on so.[order_id] = soi.[order_id]
	join [sale].[customer]		sc		on so.[customer_id] = sc.[customer_id]
	and [product_name] like 'SB-2000 12 500W Subwoofer (Piano Gloss Black)'

----- third tablosu--------
select distinct so.[customer_id],[first_name],[last_name],pp.[product_name]
into #third_ta
from [product].[product] 		pp
	join [sale].[order_item] 	soi		on pp.[product_id] = soi.[product_id]
	join [sale].[orders] 		so		on so.[order_id] = soi.[order_id]
	join [sale].[customer]		sc		on so.[customer_id] = sc.[customer_id]
	and [product_name] like 'Virtually Invisible 891 In-Wall Speakers (Pair)'

----- sonuç tablosu--------

select mt.[customer_id],mt.[first_name],mt.[last_name]
		,(f.[product_name]),s.[product_name],t.[product_name]
from #Main_Table as mt
	left join	#first_ta		f	on f.[customer_id] = mt.[customer_id]
	left join	#second_ta		s	on s.[customer_id] = mt.[customer_id]
	left join	#third_ta		t	on t.[customer_id] = mt.[customer_id]
order by mt.[customer_id]


---- isnull and replace code --------

select mt.[customer_id],mt.[first_name],mt.[last_name]
			,replace(isnull(f.[product_name],'NO'),'Polk Audio - 50 W Woofer - Black','YES') First_product
			,replace(isnull(s.[product_name],'NO'),'SB-2000 12 500W Subwoofer (Piano Gloss Black)','YES') Second_product
			,replace(isnull(t.[product_name],'NO'),'Virtually Invisible 891 In-Wall Speakers (Pair)','YES') Third_product		
from #Main_Table as mt
	left join	#first_ta		f	on f.[customer_id] = mt.[customer_id]
	left join	#second_ta		s	on s.[customer_id] = mt.[customer_id]
	left join	#third_ta		t	on t.[customer_id] = mt.[customer_id]
order by mt.[customer_id]



---- other solution------

select distinct so.[customer_id],[first_name],[last_name],pp.[product_name]
into #Main_Tab
from [product].[product] 		pp
	join [sale].[order_item] 	soi		on pp.[product_id] = soi.[product_id]
	join [sale].[orders] 		so		on so.[order_id] = soi.[order_id]
	join [sale].[customer]		sc		on so.[customer_id] = sc.[customer_id]


select mt.[customer_id],mt.[first_name],mt.[last_name]
			,replace(isnull(f.[product_name],'NO'),'Polk Audio - 50 W Woofer - Black','YES') First_product
			,replace(isnull(s.[product_name],'NO'),'SB-2000 12 500W Subwoofer (Piano Gloss Black)','YES') Second_product
			,replace(isnull(t.[product_name],'NO'),'Virtually Invisible 891 In-Wall Speakers (Pair)','YES') Third_product
from (select * from #Main_Tab where product_name = '2TB Red 5400 rpm SATA III 3.5 Internal NAS HDD') as mt
	left join (select * from #Main_Tab where product_name = 'Polk Audio - 50 W Woofer - Black') 
								as f on f.[customer_id]=mt.[customer_id]
	left join (select * from #Main_Tab where product_name = 'SB-2000 12 500W Subwoofer (Piano Gloss Black)')
								as s on s.[customer_id]=mt.[customer_id]
	left join (select * from #Main_Tab where product_name = 'Virtually Invisible 891 In-Wall Speakers (Pair)')
								as t on t.[customer_id]=mt.[customer_id]
order by mt.[customer_id]






