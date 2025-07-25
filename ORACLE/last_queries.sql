SELECT
    sql_id,
    parsing_schema_name,
    last_load_time, -- Sorgunun shared pool'a yüklendiği zaman
    executions,
    elapsed_time / 1000000 AS elapsed_time_sec, -- Saniye cinsinden geçen süre
    rows_processed,
    SUBSTR(sql_fulltext, 1, 500) AS sql_text_excerpt -- Sorgunun ilk 500 karakteri
FROM
    v$sql
ORDER BY
    last_load_time DESC -- En son yüklenenleri en üste getirir
FETCH FIRST 100 ROWS ONLY; -- Oracle 12c ve sonrası için ilk 100 kaydı getirir
