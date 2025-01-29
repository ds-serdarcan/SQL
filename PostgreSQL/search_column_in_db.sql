SELECT table_schema, table_name, column_name
FROM information_schema.columns
WHERE column_name like '%item_attribute_id';
