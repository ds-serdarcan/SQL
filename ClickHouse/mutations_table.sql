SELECT *
FROM system.mutations
WHERE 1=1
and is_done = 0
and database = 'db_name' AND table = 'table_name'
ORDER BY create_time DESC
