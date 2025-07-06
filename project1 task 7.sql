with tabled as
( select 
        dc.customer,
		fgp.gross_price,
		fsm.sold_quantity,
        fsm.date
from 
    dim_customer dc
join
     fact_sales_monthly fsm
on 
     dc.customer_code = fsm.customer_code
join
     fact_gross_price fgp
on 
     fgp.product_code = fsm.product_code
) ,

sales_summary as
(select 
  monthname(date) as month_ ,
  year(date) as year_ ,
  sum(gross_price * sold_quantity) as gross_sales_amount,
  month(date) as month_order
 
 from tabled
 where 
           customer = 'Atliq Exclusive'
 group by  monthname(date),  
            year(date),
            month(date)
)
select  month_ ,
        year_ ,
		gross_sales_amount
 from 
         sales_summary
 order by 
         year_,
         month_order;