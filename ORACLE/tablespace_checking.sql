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

----------------------- alternatif
SELECT
    t.tablespace_name,
    -- Toplam boyut (MB)
    ROUND(SUM(f.bytes) / (1024 * 1024), 2) AS total_size_mb,
    -- Kullanılan alan (MB)
    ROUND(SUM(f.bytes) / (1024 * 1024) - (SELECT ROUND(SUM(s.bytes) / (1024 * 1024), 2) FROM dba_free_space s WHERE s.tablespace_name = t.tablespace_name), 2) AS used_size_mb,
    -- Boş alan (MB)
    (SELECT ROUND(SUM(s.bytes) / (1024 * 1024), 2) FROM dba_free_space s WHERE s.tablespace_name = t.tablespace_name) AS free_size_mb,
    -- Kullanılan alan yüzdesi (%)
    ROUND(((SUM(f.bytes) - (SELECT SUM(s.bytes) FROM dba_free_space s WHERE s.tablespace_name = t.tablespace_name)) / SUM(f.bytes)) * 100, 2) AS used_pct
FROM	
    dba_data_files f
JOIN
    dba_tablespaces t ON f.tablespace_name = t.tablespace_name
WHERE 1=1
    -- and t.tablespace_name = (SELECT value FROM v$parameter WHERE name = 'undo_tablespace') -- Aktif UNDO tablespace'i filtrele
GROUP BY
    t.tablespace_name;
