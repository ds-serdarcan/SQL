SELECT
    er.session_id,
    er.status,
    er.command,
    er.wait_type,
    er.wait_time,
    er.wait_resource,
    st.text AS query_text,
    er.blocking_session_id
FROM sys.dm_exec_requests er
CROSS APPLY sys.dm_exec_sql_text(er.sql_handle) AS st
WHERE er.session_id <> @@SPID;
