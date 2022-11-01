/*
How can I expand a table with a range between two dates
https://stackoverflow.com/questions/72096855/how-can-i-expand-a-table-with-a-range-between-two-dates-as-a-new-column-in-sql-s
*/
WITH
	cte_data AS (
		SELECT
			*,
			LAG(t.transaction_date)
			--LAG(t.transaction_date, 1, t.transaction_date) -- DEFAULTS NOT NEED IT
				OVER(
					PARTITION BY t.item_id
					ORDER BY t.transaction_date DESC
				) AS next_transaction_date
		FROM (
			VALUES 
				(1, '2022-01-01'::DATE, 100),
				(1, '2022-01-05', 200),
				(1, '2022-01-10', 300),
				(2, '2022-01-06', 111),
				(2, '2022-01-08', 222),
				(2, '2022-01-09', 333)

		) AS t (item_id, transaction_date, price)
	),
	
	cte_dates AS (
		SELECT
			generate_series(
				MIN(transaction_date),
				MAX(transaction_date),
				'1 day'
			)::date AS cal_date
		FROM cte_data
	)
	
SELECT
DISTINCT
	-- cte_dates.cal_date, --DEBUG
	COALESCE(cte_dates.cal_date, cte_data.transaction_date) AS calendar_date,
	-- cte_data.transaction_date, --DEBUG
	-- cte_data.next_transaction_date, --DEBUG
	cte_data.item_id,
	cte_data.price

FROM cte_data
LEFT JOIN cte_dates
	ON cte_dates.cal_date >= cte_data.transaction_date AND
		cte_dates.cal_date < cte_data.next_transaction_date
ORDER BY item_id, calendar_date
