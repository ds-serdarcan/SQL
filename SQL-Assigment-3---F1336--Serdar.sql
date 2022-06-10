
------create database-----
CREATE DATABASE [Advertisement]
USE [Advertisement]
GO

------create schema--------
CREATE SCHEMA Visitor
GO

------create table---------
CREATE TABLE Visitor.[Actions]
(
	[Visitor_ID] [smallint] NOT NULL,
	[Adv_Type] [nvarchar](20) NULL,
	[Action] [nvarchar](20) NULL,
	PRIMARY KEY ([Visitor_ID])
) 
GO

------insert values---------
insert into [Visitor].[Actions] values	('1','A','Left'),
										('2','A','Order'),
										('3','B','Left'),
										('4','A','Order'),
										('5','A','Review'),
										('6','A','Left'),
										('7','B','Left'),
										('8','B','Order'),
										('9','B','Review'),
										('10','A','Review')


------Retrieve count of total Actions and Orders for each Advertisement Type-----

select Adv_Type,[Action], count(Action) countOfAction
from [Visitor].[Actions]
group by Adv_Type, [Action]
order by Adv_Type


-----Calculate Orders (Conversion) rates for each Advertisement Type -----
-----by dividing by total count of actions casting as float by multiplying by 1.0.--
select n.[Adv_Type]
		,cast(sum(n.new_action)*1.0/count(n.new_action)  as numeric (10,2)) as Conversion_Rate
		from	(select * 
					,case [Action]
						when 'Order' then 1
						else 0
					end new_action
				from [Visitor].[Actions]
				) n
group by n.[Adv_Type]