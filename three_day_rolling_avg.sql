--group transactions by day
WITH sum_by_day AS(
  SELECT 
  	date(transaction_time) AS transaction_day,
  	sum(transaction_amount) AS sum_transaction_amount
  FROM
  	transactions
  GROUP BY 1),
--get previous day and previous 2 day
lag_results AS (
Select
  	transaction_day,
  	sum_transaction_amount,
	lag(sum_transaction_amount,1) OVER(ORDER BY transaction_day ASC) AS previous_day_transaction,
    	lag(sum_transaction_amount,2) OVER(ORDER BY transaction_day ASC) AS previous_2_day_transaction
FROM 
  sum_by_day
ORDER BY
  1 ASC
        )
SELECT 
	transaction_day, 		
	(sum_transaction_amount+previous_day_transaction+previous_2_day_transaction)/ 3 as three_day_rolling_avg
FROM 
	lag_results
