select quarter(fact_sales_monthly.date) as Quarter,
 sum(sold_quantity) as total_sold_quantity
FROM 
 fact_sales_monthly
where 
 fiscal_year = "2020"
group by Quarter
order by total_sold_quantity desc;
