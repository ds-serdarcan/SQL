create or replace view vw_review_metrics_all as
select id, user_id, username
, start_datetime, end_datetime
, number_of_merge_requests, number_of_comments
, lines_changed, challenge_factor
, impact_factor, attention_factor
, score, 'Project1' as project from Imported.review_metrics_project1
union all
select id, user_id, username
, start_datetime, end_datetime
, number_of_merge_requests, number_of_comments
, lines_changed, challenge_factor
, impact_factor, attention_factor
, score, 'Project2' as project from Imported.review_metrics_project2
