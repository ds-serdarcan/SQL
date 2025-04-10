SELECT job_name,
       job_action
       start_date,
       last_start_date,
       last_run_duration,
       repeat_interval 
FROM all_scheduler_jobs
WHERE OWNER = 'OWNER_NAME'
