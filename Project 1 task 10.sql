SELECT *
FROM dim_product;

SELECT dp.product_code,product,division,sum(sold_quantity) as total_sold_qty
from fact_sales_monthly fsm, dim_product dp
where fsm.product_code = dp.product_code
and fiscal_year = '2021'
group by division,dp.product_code,product
order by total_sold_qty desc
;

WITH product_sales AS (
  SELECT 
    p.division,
    p.product_code,
    p.product,
    SUM(f.sold_quantity) AS total_sold_quantity
  FROM 
    fact_sales_monthly AS f
    JOIN dim_product AS p ON f.product_code = p.product_code
  WHERE 
    f.fiscal_year = '2021'
  GROUP BY 
    p.division,
    p.product_code,
    p.product
),
ranked_products AS (
  SELECT 
    division,
    product_code,
    product,
    total_sold_quantity,
    ROW_NUMBER() OVER (
      PARTITION BY division
      ORDER BY total_sold_quantity DESC
    ) AS rank_order
  FROM 
    product_sales
)
SELECT 
  division,
  product_code,
  product,
  total_sold_quantity,
  rank_order
FROM 
  ranked_products
WHERE 
  rank_order <= 3;





 SELECT 
    p.division,
    p.product_code,
    p.product,
    SUM(f.sold_quantity) AS total_sold_quantity
  FROM 
    fact_sales_monthly AS f
    JOIN dim_product AS p ON f.product_code = p.product_code
  WHERE 
    f.fiscal_year = '2021'
  GROUP BY 
    p.division,
    p.product_code,
    p.product;
    
    
    WITH product_sales AS (
  SELECT 
    p.division,
    p.product_code,
    p.product,
    SUM(f.sold_quantity) AS total_sold_quantity
  FROM 
    fact_sales_monthly AS f
    JOIN dim_product AS p ON f.product_code = p.product_code
  WHERE 
    f.fiscal_year = '2021'
  GROUP BY 
    p.division,
    p.product_code,
    p.product
),
 ranked_products AS (

  SELECT 
    division,
    product_code,
    product,
    total_sold_quantity,
    ROW_NUMBER() OVER (
      PARTITION BY division
      ORDER BY total_sold_quantity DESC
    ) AS rank_order
  FROM 
    product_sales)
    
    select
     division,
     product_code,
     product,
     total_sold_quantity,
	 rank_order
      
      from ranked_products
      where rank_order <= 3;