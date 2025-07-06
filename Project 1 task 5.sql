SELECT 
fmc.manufacturing_cost,
dp.product_code,
dp.product

from dim_product as dp
join fact_manufacturing_cost as fmc
on dp.product_code = fmc.product_code

where manufacturing_cost = (select min(manufacturing_cost) from fact_manufacturing_cost)
or  manufacturing_cost =  (select max(manufacturing_cost) from fact_manufacturing_cost)
;