SHOW VARIABLES LIKE 'general_log%';

SHOW VARIABLES LIKE 'log_output%';

-- 1. Log çıktısını tabloya yazacak şekilde ayarla
SET GLOBAL log_output = 'FILE';  -- FILE --TABLE

-- 2. Genel loglamayı aktif et
SET GLOBAL general_log = 'OFF'; -- OFF -- ON

SELECT event_time, user_host, argument 
FROM mysql.general_log 
WHERE argument LIKE '%table%'
ORDER BY event_time DESC;
