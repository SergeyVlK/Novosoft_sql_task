select Good_code, sum(case docs.In_out_flag 
            when 1 then qte * price 
            when 0 then qte * price * (-1) 
            end)
from goods
join docs using(doc_cod)
where docs.state= true
group by goods.Good_code;