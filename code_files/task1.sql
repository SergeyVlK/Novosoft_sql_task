select good_code, sum(case docs.in_out_flag 
            when true then qte * price 
            when false then qte * price * (-1) 
            end)
from goods
join docs using(doc_cod)
where docs.state= true
group by goods.good_code;