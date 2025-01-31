create table if not exists mart.f_customer_retention (
	new_customers_count int4,  -- кол-во новых клиентов (тех, которые сделали только один заказ за рассматриваемый промежуток времени).
	returning_customers_count int4,  -- кол-во вернувшихся клиентов (тех, которые сделали только несколько заказов за рассматриваемый промежуток времени).
	refunded_customer_count int4,  -- кол-во клиентов, оформивших возврат за рассматриваемый промежуток времени.
	period_name varchar default 'weekly',  -- weekly.
	period_id int4,  -- идентификатор периода (номер недели или номер месяца).
	item_id int4,  -- идентификатор категории товара.
	new_customers_revenue numeric(10, 2),  -- доход с новых клиентов.
	returning_customers_revenue numeric(10, 2),  -- доход с вернувшихся клиентов.
	customers_refunded int4  -- количество возвратов клиентов.
);