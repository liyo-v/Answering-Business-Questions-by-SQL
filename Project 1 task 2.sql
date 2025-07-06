SELECT *
FROM dim_product;

SELECT *
FROM fact_gross_price;


select  

count(distinct case  when FISCAL_year = 2020 then product_code end) as unique_products_2020,
count(distinct case  when FISCAL_year = 2021 then product_code end) as unique_products_2021,

Round (100* 
         (count(distinct case  when FISCAL_year = 2021 then product_code end) -
		 count(distinct case  when FISCAL_year = 2020 then product_code end)
	 ) /  count(distinct case  when FISCAL_year = 2020 then product_code end), 2) as percentage_chg 
        from fact_gross_price
;

