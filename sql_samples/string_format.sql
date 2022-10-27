-- https://www.postgresqltutorial.com/postgresql-string-functions/postgresql-format/
SELECT
	*,

	-- simple case
	FORMAT('Hi %s!', name) AS m1,

	-- using possition 
	FORMAT('Hi %1$s, your age is: %2$s', name, age) AS m2,

	-- using case in the possition
	FORMAT('Hi %1$s, your age is: %2$s and you are %3$s thirty', 
		   		name, 
		   		age, 
				case when age > 30 then 'OVER' else 'UNDER' end
		  ) AS m3
FROM (
	VALUES 
		(32, 'Mario'), 
		(29, 'Anna'), 
		(30, 'Jon')
	) AS t1 (age, name)

