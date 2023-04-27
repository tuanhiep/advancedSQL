USE mavenfuzzyfactory;

SELECT
	*
FROM website_pageviews
WHERE website_pageview_id < 1000 -- arbitrary
;

SELECT
	pageview_url,
    count(DISTINCT website_pageview_id) AS page_views
FROM website_pageviews
WHERE website_pageview_id < 1000 -- arbitrary
GROUP BY pageview_url
ORDER BY page_views
DESC
;

CREATE TEMPORARY TABLE first_pageview
SELECT
	website_session_id,
    MIN(website_pageview_id) as min_page_view_id

FROM website_pageviews
WHERE website_pageview_id < 1000 -- arbitrary
GROUP BY website_session_id
;

SELECT *
FROM first_pageview
;

SELECT
	first_pageview.website_session_id,
    website_pageviews.pageview_url AS landing_page
FROM first_pageview
	LEFT JOIN website_pageviews
		ON first_pageview.min_page_view_id = website_pageviews.website_pageview_id
;

SELECT
	count(DISTINCT first_pageview.website_session_id) AS session_hitting_this_lander,
    website_pageviews.pageview_url AS landing_page
FROM first_pageview
	LEFT JOIN website_pageviews
		ON first_pageview.min_page_view_id = website_pageviews.website_pageview_id
GROUP BY
landing_page
;

SELECT
    website_pageviews.pageview_url AS landing_page,
    count(DISTINCT website_pageviews.website_pageview_id) AS page_views
FROM website_pageviews
WHERE website_pageviews.created_at < '2012-06-09'
GROUP BY
	landing_page
ORDER BY
	page_views
DESC
;

-- STEP 1: find the first pageview for each session
-- STEP 2: find the url the customer saw on that first pageview





