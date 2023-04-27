USE mavenfuzzyfactory;

SELECT
utm_content,
count(DISTINCT website_sessions.website_session_id) AS sessions,
count(DISTINCT orders.order_id) AS orders,
count(DISTINCT orders.order_id)/count(DISTINCT website_sessions.website_session_id) AS sesion_to_order_conversion_rate

FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id

WHERE website_sessions.website_session_id BETWEEN 1000 AND 2000 -- arbitrary

GROUP BY 1
ORDER BY 2 DESC;


SELECT
	website_sessions.utm_source,
    website_sessions.utm_campaign,
    website_sessions.http_referer,
    count(DISTINCT website_sessions.website_session_id) AS sessions,
    count(DISTINCT orders.order_id) AS orders,
    count(DISTINCT orders.order_id)/count(DISTINCT website_sessions.website_session_id) AS session_to_order_conversion_rate
FROM website_sessions
	LEFT JOIN orders
		ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2012-04-14'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY
	website_sessions.utm_source,
	website_sessions.utm_campaign,
    website_sessions.http_referer
ORDER BY sessions
DESC;

SELECT * FROM orders;


SELECT
    year(created_at),
    week(created_at),
    MIN(DATE(created_at)) AS week_start,
    count(DISTINCT(website_session_id)) as sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000 -- arbitrary
GROUP BY 1,2
ORDER BY sessions
DESC;

SELECT
	primary_product_id,
    order_id,
    items_purchased,
    CASE WHEN items_purchased = 1 THEN order_id ELSE NULL END AS single_item_orders,
    CASE WHEN items_purchased = 2 THEN order_id ELSE NULL END AS two_item_orders
FROM orders
WHERE order_id BETWEEN 31000 AND 32000;

SELECT
	primary_product_id,
    order_id,
    items_purchased,
    count(DISTINCT CASE WHEN items_purchased = 1 THEN order_id ELSE NULL END) AS count_single_item_orders,
    count(DISTINCT CASE WHEN items_purchased = 2 THEN order_id ELSE NULL END) AS count_two_item_orders
FROM orders
WHERE order_id BETWEEN 31000 AND 32000
GROUP BY 1, 2, 3;

SELECT
	primary_product_id,
    count(DISTINCT CASE WHEN items_purchased = 1 THEN order_id ELSE NULL END) AS count_single_item_orders,
    count(DISTINCT CASE WHEN items_purchased = 2 THEN order_id ELSE NULL END) AS count_two_item_orders
FROM orders
WHERE order_id BETWEEN 31000 AND 32000
GROUP BY 1;


SELECT
    year(created_at),
    week(created_at),
    MIN(DATE(created_at)) AS week_start,
    count(DISTINCT(website_session_id)) as sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000 -- arbitrary
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY 1,2
ORDER BY sessions
DESC;

SELECT
    -- year(created_at),
    -- week(created_at),
    MIN(DATE(created_at)) AS week_start,
    count(DISTINCT(website_session_id)) as sessions
FROM website_sessions
WHERE created_at < '2012-05-12'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY
	year(created_at),
    week(created_at)
-- ORDER BY sessions
-- DESC
;

SELECT
	website_sessions.device_type,
    count(DISTINCT website_sessions.website_session_id) AS sessions,
    count(DISTINCT orders.order_id) AS orders,
    count(DISTINCT orders.order_id)/count(DISTINCT website_sessions.website_session_id) as session_to_order_conversion_rate

FROM website_sessions
	LEFT JOIN orders
		ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-05-11'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'

GROUP BY
	website_sessions.device_type








