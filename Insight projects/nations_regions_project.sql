--!!!!!!!!whole script needs any data removed where uk demogs aren't present.
--!!!!!!!!also needs level3 replacing with bbc_site or countername

-- get data for sport


CREATE TABLE central_insights_sandbox.sho_nations_regions_sport_data
(
  bbc_hid3 VARCHAR(4000),
  week_number INT,
  platform VARCHAR(4000),
  page_views INT,
  acorn_category VARCHAR(4000),
  acorn_group VARCHAR(4000),
  acorn_type VARCHAR(4000),
  age_range VARCHAR(4000),
  gender VARCHAR(4000),
  barb_region VARCHAR(4000),
  nation VARCHAR(4000)
  );

INSERT INTO central_insights_sandbox.sho_nations_regions_sport_data
SELECT
  view_watch_daily_summary.bbc_hid3,
  extract(WEEK FROM date) AS week_number,
  ns_v_platform,
  sum(page_views),
  prez.profile_extension.acorn_category_description,
  prez.profile_extension.acorn_group_description,
  prez.profile_extension.acorn_type_description,
  prez.profile_extension.age_range,
  prez.profile_extension.gender,
  prez.profile_extension.barb_region,
  prez.profile_extension.nation
FROM central_insights.view_watch_daily_summary
JOIN prez.profile_extension ON view_watch_daily_summary.bbc_hid3 = prez.profile_extension.bbc_hid3
WHERE level3 = 'sport'
AND (bbc_site = 'sport' OR name LIKE 'sport.%')
AND date BETWEEN '2017-10-02' AND '2018-04-01'
GROUP BY view_watch_daily_summary.bbc_hid3, week_number, ns_v_platform, profile_extension.acorn_category_description, profile_extension.acorn_group_description, profile_extension.acorn_type_description, profile_extension.age_range, profile_extension.gender, barb_region, profile_extension.nation
;

-- get average weekly page views for each hid and count of weeks visited
CREATE TABLE central_insights_sandbox.sho_nations_regions_sport_average
AS
WITH
  temp AS
    (SELECT bbc_hid3, platform, acorn_category, acorn_group, acorn_type, age_range, gender, barb_region, nation,
      avg(page_views) OVER (partition BY bbc_hid3)
     FROM central_insights_sandbox.sho_nations_regions_sport_data
     WHERE barb_region NOTNULL
     AND age_range NOTNULL
     AND gender NOTNULL)),
  week_counts AS
    (SELECT bbc_hid3, count(week_number) AS weeks_visited
     FROM central_insights_sandbox.sho_nations_regions_sport_data
     GROUP BY bbc_hid3, week_number)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3;


--get data for News


CREATE TABLE central_insights_sandbox.sho_nations_regions_news_data
(
  bbc_hid3 VARCHAR(4000),
  week_number INT,
  platform VARCHAR(4000),
  page_views INT,
  acorn_category VARCHAR(4000),
  acorn_group VARCHAR(4000),
  acorn_type VARCHAR(4000),
  age_range VARCHAR(4000),
  gender VARCHAR(4000),
  barb_region VARCHAR(4000),
  nation VARCHAR(4000)
  );
COMMIT ;

INSERT INTO central_insights_sandbox.sho_nations_regions_news_data
SELECT
  view_watch_daily_summary.bbc_hid3,
  extract(WEEK FROM date) AS week_number,
  ns_v_platform,
  sum(page_views),
  prez.profile_extension.acorn_category_description,
  prez.profile_extension.acorn_group_description,
  prez.profile_extension.acorn_type_description,
  prez.profile_extension.age_range,
  prez.profile_extension.gender,
  prez.profile_extension.barb_region,
  prez.profile_extension.nation
FROM central_insights.view_watch_daily_summary
JOIN prez.profile_extension ON view_watch_daily_summary.bbc_hid3 = prez.profile_extension.bbc_hid3
WHERE level3 = 'news-v2-nonws'
AND (bbc_site = 'news' OR name LIKE 'news.%')
AND date BETWEEN '2017-10-02' AND '2018-04-01'
GROUP BY view_watch_daily_summary.bbc_hid3, week_number, ns_v_platform, profile_extension.acorn_category_description, profile_extension.acorn_group_description, profile_extension.acorn_type_description, profile_extension.age_range, profile_extension.gender, barb_region, profile_extension.nation
;
COMMIT;
-- get average weekly page views for each hid and count of weeks visited
CREATE TABLE central_insights_sandbox.sho_nations_regions_news_average
AS
WITH
  temp AS
    (SELECT bbc_hid3, platform, acorn_category, acorn_group, acorn_type, age_range, gender, barb_region, nation
     FROM central_insights_sandbox.sho_nations_regions_news_data
     WHERE barb_region NOTNULL
     AND age_range NOTNULL
     AND gender NOTNULL),
  week_counts AS
    (SELECT bbc_hid3, count(week_number) AS weeks_visited
     FROM central_insights_sandbox.sho_nations_regions_news_data
     GROUP BY bbc_hid3),
  page_view AS
    (SELECT bbc_hid3, week_number, sum(page_views) AS page_views
     FROM central_insights_sandbox.sho_nations_regions_news_data
     GROUP BY bbc_hid3, week_number)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited,
  avg(page_view.page_views)  OVER (partition by page_view.bbc_hid3)
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3
JOIN page_view
ON temp.bbc_hid3 = page_view.bbc_hid3;

COMMIT;

--get data for iPlayer


CREATE TABLE central_insights_sandbox.sho_nations_regions_iplayer_data
(
  bbc_hid3 VARCHAR(4000),
  week_number INT,
  platform VARCHAR(4000),
  requests INT,
  time_spent INT,
  acorn_category VARCHAR(4000),
  acorn_group VARCHAR(4000),
  acorn_type VARCHAR(4000),
  age_range VARCHAR(4000),
  gender VARCHAR(4000),
  barb_region VARCHAR(4000),
  nation VARCHAR(4000)
  );

INSERT INTO central_insights_sandbox.sho_nations_regions_iplayer_data
SELECT
  view_watch_daily_summary.bbc_hid3,
  extract(WEEK FROM date) AS week_number,
  ns_v_platform,
  count(DISTINCT CASE WHEN length_of_stream > 3 THEN ns_st_id ELSE NULL END) AS requests,
  sum(length_of_stream),
  prez.profile_extension.acorn_category_description,
  prez.profile_extension.acorn_group_description,
  prez.profile_extension.acorn_type_description,
  prez.profile_extension.age_range,
  prez.profile_extension.gender,
  prez.profile_extension.barb_region,
  prez.profile_extension.nation
FROM central_insights.view_watch_daily_summary
JOIN prez.profile_extension ON view_watch_daily_summary.bbc_hid3 = prez.profile_extension.bbc_hid3
WHERE level3 = 'tvandiplayer'
AND (bbc_site = 'tvandiplayer' OR name LIKE 'iplayer.%')
AND date BETWEEN '2017-10-02' AND '2018-04-01'
AND version_id_merge NOTNULL
GROUP BY view_watch_daily_summary.bbc_hid3, week_number, ns_v_platform, profile_extension.acorn_category_description, profile_extension.acorn_group_description, profile_extension.acorn_type_description, profile_extension.age_range, profile_extension.gender, barb_region, profile_extension.nation
;

-- get average weekly requests for each hid and count of weeks visited
CREATE TABLE central_insights_sandbox.sho_nations_regions_sport_average
AS
WITH
  temp AS
    (SELECT bbc_hid3, platform, acorn_category, acorn_group, acorn_type, age_range, gender, barb_region, nation,
      avg(requests) OVER (partition BY bbc_hid3)
     FROM central_insights_sandbox.sho_nations_regions_iplayer_data
     WHERE barb_region NOTNULL
     AND age_range NOTNULL
     AND gender NOTNULL)),
  week_counts AS
    (SELECT bbc_hid3, count(week_number) AS weeks_visited
     FROM central_insights_sandbox.sho_nations_regions_iplayer_data
     GROUP BY bbc_hid3, week_number)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3;




--!!!!!!!!change dates to give whole weeks only!!!!!!!!


SELECT split_part(name, '.', 1),level3, bbc_site, sum(page_views)
FROM central_insights.view_watch_daily_summary
WHERE level3 = 'news-v2-nonws'
GROUP BY name, level3, bbc_site, page_views
ORDER BY page_views desc
limit 2000;

SELECT bbc_hid3, platform, acorn_category, acorn_group, acorn_type, age_range, gender, barb_region, nation,
      avg(page_views) OVER (partition BY bbc_hid3)
     FROM central_insights_sandbox.sho_nations_regions_news_data
     WHERE barb_region NOTNULL
     AND age_range NOTNULL
     AND gender NOTNULL
ORDER BY bbc_hid3
limit 1000;


