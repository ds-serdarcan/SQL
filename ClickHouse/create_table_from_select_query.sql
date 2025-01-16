create table ch_kickstarter 
ENGINE = MergeTree   -- describe engine
ORDER BY id          -- describe order by
as
select * from default.kickstarter
