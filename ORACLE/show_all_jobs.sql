SELECT job_name,
       job_action
       start_date,
       last_start_date,
       last_run_duration,
       repeat_interval 
FROM all_scheduler_jobs
WHERE 1=1
AND OWNER = 'OWNER_NAME'
AND STATE <> 'DISABLED' ;
