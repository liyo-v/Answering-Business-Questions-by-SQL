select dp.segment,
count(distinct case when fiscal_year = 2021 then fg.product_code end )as  Product_count_2021,
 count(distinct case when fiscal_year = 2020 then fg.product_code end)as  Product_count_2020,
count(distinct case when fiscal_year = 2021 then fg.product_code end) - 
count(distinct case when fiscal_year = 2020 then fg.product_code end)as  difference
	
from
fact_gross_price as fg
    
join
dim_product as dp

on dp.product_code= fg.product_code
 
group by dp.segment
order by difference desc
limit 1;