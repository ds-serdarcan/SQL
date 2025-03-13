SELECT *
FROM url(
    'https://api.spacexdata.com/v4/launches',
    'JSONEachRow',
    -- 'column1 String, column2 UInt32',  -- optional column names
    headers('accept'='application/json', 'Authorization'='Bearer your_token')
)
SETTINGS 
    verify_host=0, 
    verify_peer=0, 
    http_connection_timeout=60, 
    http_receive_timeout=300, 
    http_send_timeout=300
