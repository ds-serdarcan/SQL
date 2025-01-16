create table ch_kickstarter 
ENGINE = MergeTree
ORDER BY id as
select * from default.kickstarter
