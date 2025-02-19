SELECT tablespace_name, 
       file_name, 
       bytes / 1024 / 1024 AS size_mb
FROM dba_data_files
WHERE tablespace_name = 'USERS';
