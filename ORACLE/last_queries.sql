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

--------------------------
SELECT sql_id,sql_text,module,status, sql_exec_start, 
       elapsed_time / 1000000 AS sure_sn, 
       cpu_time / 1000000 AS cpu_sn,
       queuing_time / 1000000 AS kuyrukta_bekleme_sn
FROM v$sql_monitor
WHERE upper(sql_text) LIKE '%TMPGTTUNTITLEDVIEW2%'
ORDER BY sql_exec_start DESC;

------------------------
SELECT 
    sql_id, 
    sql_text, 
    executions, 
    elapsed_time / 1000000 AS toplam_sn,
    (elapsed_time / decode(executions, 0, 1, executions)) / 1000000 AS ortalama_sn,
    last_active_time
FROM v$sql
WHERE upper(sql_text) LIKE '%TMPGTTUNTITLEDVIEW2%'
ORDER BY last_active_time DESC;
