
with customer_name as
(SELECT 
FPED.customer_code,
DC.customer,
DC.market,
avg(FPED.pre_invoice_discount_pct) as average_discount_percentage 

 FROM  
     fact_pre_invoice_deductions as FPED
 join
     dim_customer as DC
 on 
     DC.customer_code = FPED.customer_code
 where 
      FPED.fiscal_year = 2021 
 group by 
     FPED.customer_code,DC.customer,DC.market
 )
 SELECT customer_code,
        customer,
        average_discount_percentage 
 FROM 
        customer_name
 where 
         market = 'India'
ORDER BY 
        average_discount_percentage  DESC 
 LIMIT 5 
  ;
 