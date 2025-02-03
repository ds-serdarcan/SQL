CREATE TABLE infinitysoft.sales_stockvalue_turnoverrate
(

    `record_id` UUID DEFAULT generateUUIDv4(),

    `period_date` Date,

    `period_year` Int32,

    `period_month` String,

    `currency` String,

    `turnover_rate` Float64,

    `stock_value` Float64
)
ENGINE = MergeTree()
PARTITION BY toYYYYMM(period_date) -- Aylık partition
ORDER BY (record_id)
