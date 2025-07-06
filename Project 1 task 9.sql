
  
 with retailer as
( select 
  fgp.fiscal_year, sum(gross_price*sold_quantity)AS gross_sales_mln,channel
  from 
    fact_gross_price as fgp,fact_sales_monthly as fsm,dim_customer AS DC
 WHERE 
  fsm.product_code = fgp.product_code 
 and 
  fsm.customer_code = DC.customer_code
 and 
  fgp.fiscal_year = "2021" 
 and 
   channel ="retailer"
group by channel, fgp.fiscal_year)

,
 every as
 
(select
  fgp.fiscal_year, sum(gross_price*sold_quantity)AS gross_sales_mln
 from
  fact_gross_price as fgp,fact_sales_monthly as fsm,dim_customer AS DC
 WHERE 
  fsm.product_code = fgp.product_code 
 and 
  fsm.customer_code = DC.customer_code
 and 
  fgp.fiscal_year = "2021" 
 group by 
   fgp.fiscal_year)

select 
   r.channel, r.gross_sales_mln,
   round(r.gross_sales_mln / e.gross_sales_mln,2)* 100
   as percentage
from 
   retailer r cross join every e;