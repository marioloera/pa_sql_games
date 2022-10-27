--
-- By default, PostgreSQL assigns the names column1, column2,
VALUES (1, 'one'), (2, 'two'), (3, 'three');

-- VALUES IN cte
with CTE as (
	VALUES 
		(1, 'one'), 
		(2, 'two'), 
		(3, 'three')
) 
select *
from CTE;

-- VALUES AS SUBQUERY
SELECT *
FROM (
	VALUES 
		(1, 'one'), 
		(2, 'two'), 
		(3, 'three')
) AS t (num,letter);
