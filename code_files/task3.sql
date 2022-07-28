select t1.name "Название кабинета", t1.count_visits "Суммарное число оказанных приемов" 
from (	select cablabs.name as name, count(visits.id) as  count_visits
		from cablabs
		join visits on visits.cablab_id = cablabs.id
	  	group by cablabs.id
		) as t1
where t1.count_visits = (select max(t1.count_visits) from t1);