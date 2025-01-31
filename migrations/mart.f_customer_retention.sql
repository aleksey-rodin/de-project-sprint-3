delete from mart.f_customer_retention;
insert into mart.f_customer_retention (
	new_customers_count,
	returning_customers_count,
	refunded_customer_count,
	period_name,
	period_id,
	item_id,
	new_customers_revenue,
	returning_customers_revenue,
	customers_refunded
)
select
	count(case when sub.cnt = 1 and sub.status = 'shipped' then sub.customer_id end) as new_customers_count,
	count(case when sub.cnt > 1 and sub.status = 'shipped' then sub.customer_id end) as returning_customers_count,
	count(case when sub.status = 'refunded' then sub.customer_id end) as refunded_customer_count,
	'weekly' as period_name,
	sub.week_of_year as period_id,
	sub.item_id as item_id,
	sum(case when sub.cnt = 1 and sub.status = 'shipped' then sub.payment_amount end) as new_customers_revenue,
	sum(case when sub.cnt > 1 and sub.status = 'shipped' then sub.payment_amount end) as returning_customers_revenue,
	count(case when sub.status = 'refunded' then sub.customer_id end) as customers_refunded
from (
	select
		count(*) as cnt,
		sum(s.payment_amount) as payment_amount,
		s.customer_id,
		s.status,
		s.item_id,
		dc.week_of_year,
		extract(year from dc.last_day_of_week) as year
	from mart.f_sales s
	join mart.d_calendar dc on dc.date_id = s.date_id
	group by
		s.customer_id,
		s.status,
		s.item_id,
		dc.week_of_year,
		extract(year from dc.last_day_of_week)
	) sub
group by
	sub.year,
	sub.week_of_year,
	sub.item_id
;