
----///---- minimum indirim de�eri ba�lang�� de�eri olarak kabul edilmi�  ----///----
----///---- minimum indirim d���ndaki indirimlerin quantity ortalamas� al�nm��  ----///----
----///----	ve ba�lang�� de�erindeki quantity aras�nda k�yaslama yap�larak ----///----
----///---- ili�ki kurulmu�tur.      ----///----

create view main_t as
select	 [product_id],discount
		,sum([quantity]) quantity_sum
		,count([order_id])count_o
from [sale].[order_item]
group by [product_id],discount

select product_id,
    CASE WHEN (A.quantity_avg - quantity_sum) > 0 THEN  'Positive'
         WHEN (A.quantity_avg - quantity_sum) < 0 THEN  'Negative'
         ELSE 'Neutral'
    END 'Discount Effect'
from (
    select *
        , avg(quantity_sum) over(partition by product_id order by discount rows between current row and unbounded following ) quantity_avg
        , DENSE_RANK() over(partition by product_id order by discount) discount_rank
    from main_t
    ) A
where A.discount_rank=1