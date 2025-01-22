----- from information schema ------
SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'sales';

----- from pg_catalog.pg_attribute ------
SELECT 
    a.attname AS column_name, 
    pg_catalog.format_type(a.atttypid, a.atttypmod) AS data_type,
    a.attnotnull AS is_not_null
FROM 
    pg_catalog.pg_attribute a
JOIN 
    pg_catalog.pg_class c ON c.oid = a.attrelid
WHERE 
    c.relname = 'sales' AND 
    a.attnum > 0 AND 
    NOT a.attisdropped
ORDER BY 
    a.attnum;
