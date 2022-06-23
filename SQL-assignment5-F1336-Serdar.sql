

-------
------faktoriyel fonksiyonu------
create function dbo.faktoriyel
	(
	@num int
	)
returns int
as
begin
	declare @return int
	set @return = 1
begin 
while	@num > 0
	begin
		set @return = @return * @num
		set @num = @num - 1
	end
end
return @return
end
--------------------
------------
select  dbo.faktoriyel(6)