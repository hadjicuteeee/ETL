WITH sales_per_dev AS (
    SELECT 
        developer,
        SUM(total_sales) AS sales
    FROM psp
    GROUP BY developer
)
SELECT 
    developer,
    sales,
    ROW_NUMBER() OVER (ORDER BY sales DESC) AS ranking
FROM sales_per_dev;


SELECT 
    p1.developer,
    p1.release_date,
    p1.total_sales,
    (
        SELECT SUM(p2.total_sales)
        FROM psp p2
        WHERE p2.developer = p1.developer
          AND p2.release_date BETWEEN DATE_SUB(p1.release_date, INTERVAL 6 DAY) 
                                  AND p1.release_date
    ) AS week_total_sales
FROM psp p1
ORDER BY p1.developer, p1.release_date;


SELECT 
    game,
    YEAR(release_date) AS release_year,
    MONTHNAME(release_date) AS release_month,
    SUM(total_sales) AS revenue
FROM psp
WHERE total_sales IS NOT NULL
GROUP BY 
    game,
    release_year,
    release_month
HAVING 
    SUM(total_sales) > 0
ORDER BY 
    release_year, 
    FIELD(release_month, 
          'January','February','March','April','May','June',
          'July','August','September','October','November','December');
          
SELECT 
	'NA' as region,
    PERCENTILE_CONT(0.5) WITHIN GROUP (Order by na_sales) as "NA MEDIAN",
	PERCENTILE_CONT(0.9) WITHIN GROUP (Order by na_sales) as "Top Sales"
    FROM psp
    
    UNION ALL
    
    SELECT
    'JAPAN',
	PERCENTILE_CONT(0.5) WITHIN GROUP (Order by japan_sales),
	PERCENTILE_CONT(0.9) WITHIN GROUP (Order by japan_sales)
    FROM psp
    UNION ALL
    
    SELECT
    'PAL',
    PERCENTILE_CONT(0.5) WITHIN GROUP (Order by pal_sales),
	PERCENTILE_CONT(0.9) WITHIN GROUP (Order by pal_sales)
    FROM psp;
    
WITH 
NA AS (
  SELECT game, SUM(na_sales) AS revenue
  FROM psp
  GROUP BY game
  HAVING SUM(na_sales) > 0
),
na_percentage AS (
  SELECT SUM(revenue) AS total FROM NA
),
JA AS (
  SELECT game, SUM(japan_sales) AS jtotal
  FROM psp
  GROUP BY game
  HAVING SUM(japan_sales) > 0
),
PJA AS (
  SELECT SUM(jtotal) AS prcn FROM JA
),
PAL AS (
  SELECT game, SUM(pal_sales) AS ptotal
  FROM psp
  GROUP BY game
  HAVING SUM(pal_sales) > 0
),
PPAL AS (
  SELECT SUM(ptotal) AS prcntage FROM PAL
)
SELECT 
  n.game,
  CONCAT(ROUND((n.revenue / np.total) * 100, 2), '%') AS "NA PRCNTG",
  CONCAT(ROUND((j.jtotal / pj.prcn) * 100, 2), '%') AS "JAPAN PRCNTG",
  CONCAT(ROUND((p.ptotal / pp.prcntage) * 100, 2), '%') AS "PAL PRCNTG"
FROM NA n
LEFT JOIN JA j USING(game)
LEFT JOIN PAL p USING(game)
CROSS JOIN na_percentage np
CROSS JOIN PJA pj
CROSS JOIN PPAL pp;


SELECT 
    TRIM(g) AS genre,
    COUNT(*) AS total
FROM (
    SELECT UNNEST(STRING_TO_ARRAY(genres, ',')) AS g
    FROM psp
) AS sub
GROUP BY genre
ORDER BY total DESC;


WITH famous_game AS(
		SELECT name,
        sum(total_sales) as Game_Sale
        from PSP
        GROUP BY name
        HAVING sum(total_sales) > 0),

avg as (
		SELECT SUM(Game_Sale) as TOTAL
        from famous_game
)	SELECT f.name,
		   f.game_sale,
           CONCAT(ROUND((Game_Sale / TOTAL) * 100, 2 ),'%') As Shareholder
           FROM famous_game f
           CROSS JOIN avg;
           
SELECT column_name
WHERE table_name = 'psp';