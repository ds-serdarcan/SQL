
---<<<<~~~~~---TABLOLARIN IMPORT EDÝLMESÝ------~~~~~~>>>>---
-----------------------<<<<>>>>---------------------

CREATE DATABASE project
GO

---bazý iþlemler kod kullanarak
---bazý iþlemlerde tablolara sað týk "design" kýsmýndan yapýlmýþtýr.

---<<<<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>>>---
---<<<<--cust_dimen TABLOSUNUN DÜZENLENMESÝ-->>>>---

------tabloyu önce yazdýr
SELECT * FROM [dbo].[cust_dimen] ORDER BY 1


---cust_id kolonunun temizlenmesi---
---SUBSTRÝNG VEYA REPLACE komutlarý ile temizlenebilir
select substring(cust_id,6,len(cust_id)) from [dbo].[cust_dimen]
---veya
SELECT replace(cust_id,'Cust_','') from [dbo].[cust_dimen]
--------UPDATE------
update [dbo].[cust_dimen]
set [Cust_id] =  substring(cust_id,6,len(cust_id))

------ALTER COLUMN DATA-TYPE--------
alter table [dbo].[cust_dimen]
ALTER COLUMN cust_id  int


---<<<<~~~~~~~~~~~~~DÝÐERLERÝ BENZER KODLAMALAR~~~~~~~~~~~~~>>>>---

---<<<<---[dbo].[orders_dimen] TABLOSUNUN DÜZENLENMESÝ--->>>>---

select * from [dbo].[orders_dimen]
select substring([Ord_id],5,len([Ord_id])) from [dbo].[orders_dimen]

update [dbo].[orders_dimen]
set [Ord_id] =  substring([Ord_id],5,len([Ord_id])) 

ALTER TABLE [dbo].[orders_dimen]
ALTER COLUMN [Ord_id] int

---<<<<~~~~~~~~~~~~~~~~~~~~~~~~>>>>---
---<<<<---[dbo].[prod_dimen]--->>>>----
select * from [dbo].[prod_dimen]

select substring([Prod_id],6,len([Prod_id])) from [dbo].[prod_dimen]

update [dbo].[prod_dimen]
set [Prod_id] = substring([Prod_id],6,len([Prod_id]))

alter table [dbo].[prod_dimen]
alter column [Prod_id] int

---<<<<~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~>>>>---
---<<<<[dbo].[shipping_dimen] tablo düzenlemesi--->>>>----

select * from [dbo].[shipping_dimen]

select substring([Ship_id],5,len([Ship_id])) from [dbo].[shipping_dimen]

update [dbo].[shipping_dimen]
set [Ship_id] = substring([Ship_id],5,len([Ship_id])) from [dbo].[shipping_dimen]

alter table [dbo].[shipping_dimen]
alter column [Ship_id] int


---<<<<~~~~~~~~~~~~~~~~~~~~~~~~>>>>---
---<<<<---[dbo].[market_fact]-->>>>----

select * from [dbo].[market_fact]
order by 1

update [dbo].[market_fact]
set [Cust_id] =  substring(cust_id,6,len(cust_id))
,[Ord_id] =  substring([Ord_id],5,len([Ord_id])) 
,[Prod_id] = substring([Prod_id],6,len([Prod_id]))
,[Ship_id] = substring([Ship_id],5,len([Ship_id]))


--------
select * from [dbo].[market_fact]
---------
---------
---<<<<~~~~~~~~~~~~~~~~~~~~~~~~~~>>>>----
---<<<<---FOREIGN KEY ATAMALARI-->>>>----

ALTER TABLE [dbo].[market_fact]
ADD CONSTRAINT FK_market_ord
FOREIGN KEY ([Ord_id]) REFERENCES [dbo].[orders_dimen]([Ord_id]);

--------------
--------------
ALTER TABLE [dbo].[market_fact]
ADD CONSTRAINT FK_market_prod
FOREIGN KEY ([Prod_id]) REFERENCES [dbo].[prod_dimen]([Prod_id]);

--------------
-------------------
ALTER TABLE [dbo].[market_fact]
ADD CONSTRAINT FK_market_ship
FOREIGN KEY ([Ship_id]) REFERENCES [dbo].[shipping_dimen]([Ship_id]);

-----------
-----------
ALTER TABLE [dbo].[market_fact]
ADD CONSTRAINT FK_market_cust
FOREIGN KEY ([Cust_id]) REFERENCES [dbo].[cust_dimen]([Cust_id]);

------------
---------------