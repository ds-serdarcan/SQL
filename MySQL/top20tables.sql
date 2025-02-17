SELECT 
    table_schema AS database_name,
    table_name,
    ROUND((data_length + index_length) / (1024 * 1024 * 1024), 2) AS table_size_gb
FROM information_schema.tables
ORDER BY table_size_gb DESC
LIMIT 20;
