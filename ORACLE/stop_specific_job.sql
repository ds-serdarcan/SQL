BEGIN
    DBMS_SCHEDULER.STOP_JOB('MAIN', FORCE => TRUE);
END;
