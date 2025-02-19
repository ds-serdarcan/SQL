SELECT segment_name, 
       segment_type, 
       bytes / 1024 / 1024 / 1024 AS size_gb
FROM dba_segments
WHERE segment_name = 'TABLO_ADI'
  AND owner = 'SCHEMA_ADI';
