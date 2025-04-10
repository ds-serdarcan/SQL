SELECT job_name, log_date, status, additional_info
FROM dba_scheduler_job_log
WHERE job_name = 'MAIN_JOB'
ORDER BY log_date DESC;
