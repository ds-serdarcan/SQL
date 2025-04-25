SELECT
    tablespace_name,
    ROUND(SUM(bytes) / 1024 / 1024, 2) AS total_mb,
    ROUND(SUM(bytes) / 1024 / 1024 - SUM(free_space) / 1024 / 1024, 2) AS used_mb,
    ROUND(SUM(free_space) / 1024 / 1024, 2) AS free_mb
FROM
    (SELECT
         tablespace_name,
         bytes,
         0 AS free_space
     FROM dba_data_files
     UNION ALL
     SELECT
         tablespace_name,
         0 AS bytes,
         bytes AS free_space
     FROM dba_free_space)
GROUP BY
    tablespace_name;
