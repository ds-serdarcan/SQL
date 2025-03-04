create or replace view vw_review_metrics_all as
select *, 'Project1' as project from Imported.review_metrics_project1
union all
select *, 'Project2' as project from Imported.review_metrics_project2
