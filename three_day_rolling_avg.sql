WIth lag_results AS (
Select
  	transaction_time,
  	Transaction_amount,
	lag(transaction_amount,1) OVER(ORDER BY transaction_time ASC) AS previous_day_transaction,
    lag(transaction_amount,2) OVER(ORDER BY transaction_time ASC) AS previous_2_day_transaction
FROM 
  transactions
ORDER BY
  1 ASC
        )
SELECT 
	transaction_time,
    (transaction_amount+previous_day_transaction+previous_2_day_transaction)/ 3 as three_day_rolling_avg
FROM 
	lag_results
