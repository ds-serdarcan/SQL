select
    pid,
    usename,
    datname,
    application_name,
    client_addr,
    backend_start,
    state,
    query_start,
    query
FROM
    pg_stat_activity
    WHERE
    state = 'active';
