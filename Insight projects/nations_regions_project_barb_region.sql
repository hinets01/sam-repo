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
COMMIT;

-- get average weekly page views for each hid and count of weeks visited
CREATE TABLE central_insights_sandbox.sho_nations_regions_sport_average
AS
WITH temp AS
      (SELECT bbc_hid3, acorn_category, acorn_group, acorn_type, age_range, gender, barb_region, nation
       FROM central_insights_sandbox.sho_nations_regions_sport_data
       WHERE barb_region NOTNULL
       AND age_range NOTNULL
       AND gender NOTNULL),
    week_counts AS
      (SELECT bbc_hid3, count(week_number) AS weeks_visited
       FROM central_insights_sandbox.sho_nations_regions_sport_data
       GROUP BY bbc_hid3),
    page_view AS
      (SELECT bbc_hid3, week_number, sum(page_views) AS page_views
       FROM central_insights_sandbox.sho_nations_regions_sport_data
       GROUP BY bbc_hid3, week_number),
    page_view_average AS
      (SELECT bbc_hid3, avg(page_views) AS avg_page_views
       FROM page_view
       GROUP BY bbc_hid3)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited,
  page_view_average.avg_page_views
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3
JOIN page_view_average
ON temp.bbc_hid3 = page_view_average.bbc_hid3
;


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
     GROUP BY bbc_hid3, week_number),
  page_view_average AS
    (SELECT bbc_hid3, avg(page_views) AS avg_page_views
     FROM page_view
     GROUP BY bbc_hid3)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited,
  page_view_average.avg_page_views
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3
JOIN page_view_average
ON temp.bbc_hid3 = page_view_average.bbc_hid3
;

COMMIT;

--get data for Homepage


CREATE TABLE central_insights_sandbox.sho_nations_regions_homepage_data
(
  bbc_hid3 VARCHAR(4000),
  week_number INT,
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

INSERT INTO central_insights_sandbox.sho_nations_regions_homepage_data
SELECT
  view_watch_daily_summary.bbc_hid3,
  extract(WEEK FROM date) AS week_number,
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
WHERE level3 = 'homepageandsearch'
AND (bbc_site = 'homepage' OR name LIKE 'home.page')
AND date BETWEEN '2017-10-02' AND '2018-04-01'
GROUP BY view_watch_daily_summary.bbc_hid3, week_number, profile_extension.acorn_category_description, profile_extension.acorn_group_description, profile_extension.acorn_type_description, profile_extension.age_range, profile_extension.gender, barb_region, profile_extension.nation
;
COMMIT;

-- get average weekly page views for each hid and count of weeks visited
CREATE TABLE central_insights_sandbox.sho_nations_regions_homepage_average
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
     GROUP BY bbc_hid3, week_number),
  page_view_average AS
    (SELECT bbc_hid3, avg(page_views) AS avg_page_views
     FROM page_view
     GROUP BY bbc_hid3)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited,
  page_view_average.avg_page_views
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3
JOIN page_view_average
ON temp.bbc_hid3 = page_view_average.bbc_hid3
;

COMMIT;

--get data for iPlayer

CREATE TABLE central_insights_sandbox.sho_nations_regions_iplayer_data
(
  bbc_hid3 VARCHAR(4000),
  week_number INT,
  requests INT,
  time_spent BIGINT,
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
  count(DISTINCT CASE WHEN length_of_stream > '3' THEN ns_st_id ELSE NULL END) AS requests,
  sum(length_of_stream) AS INT,
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
AND length_of_stream ~ '^[[:digit:]]{0,18}$'
AND length_of_stream BETWEEN 1 AND 5184000
AND length_of_stream NOT LIKE '%.%'
AND len(length_of_stream) < 8
GROUP BY view_watch_daily_summary.bbc_hid3, week_number, profile_extension.acorn_category_description, profile_extension.acorn_group_description, profile_extension.acorn_type_description, profile_extension.age_range, profile_extension.gender, barb_region, profile_extension.nation
;
COMMIT;


-- get average weekly requests for each hid and count of weeks visited
CREATE TABLE central_insights_sandbox.sho_nations_regions_iplayer_average
AS
WITH
  temp AS
    (SELECT bbc_hid3, acorn_category, acorn_group, acorn_type, age_range, gender, barb_region, nation
     FROM central_insights_sandbox.sho_nations_regions_iplayer_data
     WHERE barb_region NOTNULL
     AND age_range NOTNULL
     AND gender NOTNULL),
  week_counts AS
    (SELECT bbc_hid3, count(week_number) AS weeks_visited
     FROM central_insights_sandbox.sho_nations_regions_iplayer_data
     GROUP BY bbc_hid3),
  metrics AS
     (SELECT bbc_hid3, week_number, sum(time_spent) AS time_spent, sum(requests) AS requests
      FROM central_insights_sandbox.sho_nations_regions_iplayer_data
      GROUP BY bbc_hid3, week_number),
  average_metrics AS
     (SELECT bbc_hid3, avg(time_spent) AS time_spent, avg(requests) AS requests
      FROM metrics
      GROUP BY bbc_hid3)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited,
  average_metrics.time_spent,
  average_metrics.requests
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3
JOIN average_metrics
ON temp.bbc_hid3 = average_metrics.bbc_hid3;

COMMIT;

--get data for Radio

drop TABLE central_insights_sandbox.sho_nations_regions_radio_data;
CREATE TABLE central_insights_sandbox.sho_nations_regions_radio_data
(
  bbc_hid3 VARCHAR(4000),
  week_number INT,
  requests INT,
  time_spent BIGINT,
  acorn_category VARCHAR(4000),
  acorn_group VARCHAR(4000),
  acorn_type VARCHAR(4000),
  age_range VARCHAR(4000),
  gender VARCHAR(4000),
  barb_region VARCHAR(4000),
  nation VARCHAR(4000)
  );

INSERT INTO central_insights_sandbox.sho_nations_regions_radio_data
SELECT
  view_watch_daily_summary.bbc_hid3,
  extract(WEEK FROM date) AS week_number,
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
WHERE level3 = 'iplayerradio'
AND (bbc_site LIKE 'iplayerradio%' OR name LIKE 'radio.%')
AND date BETWEEN '2017-10-02' AND '2018-04-01'
AND version_id_merge NOTNULL
AND length_of_stream ~ '^[[:digit:]]{0,18}$'
AND length_of_stream BETWEEN 1 AND 5184000
AND length_of_stream NOT LIKE '%.%'
AND len(length_of_stream) < 8
GROUP BY view_watch_daily_summary.bbc_hid3, week_number, profile_extension.acorn_category_description, profile_extension.acorn_group_description, profile_extension.acorn_type_description, profile_extension.age_range, profile_extension.gender, barb_region, profile_extension.nation
;
COMMIT;

-- get average weekly requests for each hid and count of weeks visited
CREATE TABLE central_insights_sandbox.sho_nations_regions_radio_average
AS
WITH
  temp AS
    (SELECT bbc_hid3, acorn_category, acorn_group, acorn_type, age_range, gender, barb_region, nation
     FROM central_insights_sandbox.sho_nations_regions_radio_data
     WHERE barb_region NOTNULL
     AND age_range NOTNULL
     AND gender NOTNULL),
  week_counts AS
    (SELECT bbc_hid3, count(week_number) AS weeks_visited
     FROM central_insights_sandbox.sho_nations_regions_radio_data
     GROUP BY bbc_hid3),
  metrics AS
     (SELECT bbc_hid3, week_number, sum(time_spent) / 60000 AS time_spent_mins, sum(requests) AS requests
      FROM central_insights_sandbox.sho_nations_regions_radio_data
      GROUP BY bbc_hid3, week_number),
  average_metrics AS
     (SELECT bbc_hid3, avg(time_spent_mins) AS time_spent_mins, avg(requests) AS requests
      FROM metrics
      GROUP BY bbc_hid3)
SELECT
  DISTINCT temp.*,
  week_counts.weeks_visited,
  average_metrics.time_spent_mins,
  average_metrics.requests
FROM temp
JOIN week_counts
ON temp.bbc_hid3 = week_counts.bbc_hid3
JOIN average_metrics
ON temp.bbc_hid3 = week_counts.bbc_hid3;

COMMIT;


--!!!!!!!!change dates to give whole weeks only!!!!!!!!


SELECT split_part(name, '.', 1),level3, bbc_site, sum(page_views)
FROM central_insights.view_watch_daily_summary
WHERE level3 = 'news-v2-nonws'
GROUP BY name, level3, bbc_site, page_views
ORDER BY page_views desc
limit 2000;

SELECT bbc_hid3, count(week_number) AS weeks_visited
     FROM central_insights_sandbox.sho_nations_regions_news_data
     GROUP BY bbc_hid3
ORDER BY bbc_hid3
LIMIT 500;

SELECT * FROM central_insights.view_watch_daily_summary
WHERE length_of_stream > '3'
AND date = '20180202'
limit 500;

SELECT bbc_hid3, week_number, sum(time_spent) AS time_spent, sum(requests) AS requests
      FROM central_insights_sandbox.sho_nations_regions_radio_data
      GROUP BY bbc_hid3, week_number
    ORDER BY bbc_hid3
limit 500;

--may have to add length_of_stream > 0 clause to AV data


CREATE TABLE central_insights_sandbox.sho_nations_regions_iplayer_aggregated
  AS
  SELECT
    time_spent,
    acorn_category,
    age_range,
    gender,
    barb_region,
    nation,
    bbc_hid3
  FROM central_insights_sandbox.sho_nations_regions_iplayer_average
    WHERE avg_page_views > 0
  GROUP BY
    avg_page_views,
    acorn_category,
    age_range,
    gender,
    barb_region,
    nation,
    bbc_hid3;


-- create data frames for R with boolean columns for age ranges/acorn categories/nation/region

CREATE TABLE central_insights_sandbox.sho_barb_regions_radio_regression
(
  bbc_hid3 VARCHAR(4000),
  acorn_category VARCHAR(4000),
  age_range VARCHAR(4000),
  gender VARCHAR(4000),
  barb_region VARCHAR(4000),
  nation VARCHAR(4000),
  total_time_spent_mins BIGINT,
  weeks_visited INT,
  is_16_24 VARCHAR(1),
  is_25_34 VARCHAR(1),
  is_35_44 VARCHAR(1),
  is_45_54 VARCHAR(1),
  is_55_64 VARCHAR(1),
  is_65_plus VARCHAR(1),
  is_aff_achiever VARCHAR(1),
  is_comf_community VARCHAR(1),
  is_urban_adversity VARCHAR(1),
  is_financially_stretched VARCHAR(1),
  is_rising_prosperity VARCHAR(1),
  is_scotland VARCHAR(1),
  is_england VARCHAR(1),
  is_nireland VARCHAR(1),
  is_wales VARCHAR(1),
  is_male VARCHAR(1),
  is_female VARCHAR(1),
  is_north VARCHAR(1),
  is_london VARCHAR(1),
  is_south VARCHAR(1),
  is_midlands VARCHAR(1),
  is_NI_barb VARCHAR(1),
  is_SCT_barb VARCHAR(1),
  is_WAL_barb VARCHAR(1)
)
;

INSERT INTO central_insights_sandbox.sho_barb_regions_radio_regression
SELECT
  bbc_hid3,
  acorn_category,
  age_range,
  gender,
  barb_region,
  nation,
  sum(time_spent) / 60000,
  count(DISTINCT week_number),
  CASE WHEN age_range IN ('16-19', '20-24') THEN '1' ELSE '0' END,
  CASE WHEN age_range IN ('25-29', '30-34') THEN '1' ELSE '0' END,
  CASE WHEN age_range IN ('35-39', '40-44') THEN '1' ELSE '0' END,
  CASE WHEN age_range IN ('45-49', '50-54') THEN '1' ELSE '0' END,
  CASE WHEN age_range IN ('55-59', '60-64') THEN '1' ELSE '0' END,
  CASE WHEN age_range IN ('65-69', '>70') THEN '1' ELSE '0' END,
  CASE WHEN acorn_category = 'Affluent Achievers' THEN '1' ELSE '0' END,
  CASE WHEN acorn_category = 'Comfortable Communities' THEN '1' ELSE '0' END,
  CASE WHEN acorn_category = 'Urban Adversity' THEN '1' ELSE '0' END,
  CASE WHEN acorn_category = 'Financially Stretched' THEN '1' ELSE '0' END,
  CASE WHEN acorn_category = 'Rising Prosperity' THEN '1' ELSE '0' END,
  CASE WHEN nation = 'Scotland' THEN '1' ELSE '0' END,
  CASE WHEN nation = 'England' THEN '1' ELSE '0' END,
  CASE WHEN nation = 'Northern Ireland' THEN '1' ELSE '0' END,
  CASE WHEN nation = 'Wales' THEN '1' ELSE '0' END,
  CASE WHEN gender = 'male' THEN '1' ELSE '0' END,
  CASE WHEN gender = 'female' THEN '1' ELSE '0' END,
  CASE WHEN barb_region IN ('Yorkshire and Lincolnshire', 'North East and Cumbria', 'North West') THEN '1' ELSE '0' END,
  CASE WHEN barb_region = 'London' THEN '1' ELSE '0' END,
  CASE WHEN barb_region IN ('South East', 'South', 'South West', 'West') THEN '1' ELSE '0' END,
  CASE WHEN barb_region IN ('Midlands East', 'East of England', 'Midlands West') THEN '1' ELSE '0' END,
  CASE WHEN barb_region = 'Ulster' THEN '1' ELSE '0' END,
  CASE WHEN barb_region = 'Scotland' THEN '1' ELSE '0' END,
  CASE WHEN barb_region = 'Wales' THEN '1' ELSE '0' END
FROM central_insights_sandbox.sho_nations_regions_radio_data
  WHERE
    age_range NOTNULL
    AND barb_region NOTNULL
    AND gender NOTNULL
    AND nation NOTNULL
    AND acorn_category NOTNULL
GROUP BY
  bbc_hid3,
  acorn_category,
  age_range,
  barb_region,
  nation,
  gender
;


-- get unique days visited for each product
CREATE TABLE central_insights_sandbox.sho_barb_regions_homepage_daycount
AS
SELECT bbc_hid3, count(DISTINCT date)
FROM central_insights.view_watch_daily_summary
WHERE level3 = 'homepageandsearch'
AND (bbc_site = 'homepage' OR name LIKE 'home.page')
AND date BETWEEN '2017-10-02' AND '2018-04-01'
GROUP BY bbc_hid3
;

-- add day counts to original tables
ALTER TABLE central_insights_sandbox.sho_barb_regions_sport_regression
    ADD COLUMN days_visited INT;
UPDATE central_insights_sandbox.sho_barb_regions_sport_regression
    SET days_visited = central_insights_sandbox.sho_nations_regions_sport_daycount.count
FROM central_insights_sandbox.sho_nations_regions_sport_daycount
WHERE central_insights_sandbox.sho_nations_regions_sport_daycount.bbc_hid3 = central_insights_sandbox.sho_barb_regions_sport_regression.bbc_hid3;


ALTER TABLE central_insights_sandbox.sho_barb_regions_sport_regression
    ADD COLUMN avg_page_views INT;
UPDATE central_insights_sandbox.sho_barb_regions_sport_regression
    SET avg_page_views = sho_barb_regions_sport_regression.total_page_views/ sho_barb_regions_sport_regression.weeks_visited
;


-- issue with homepage page views when regions added, so do again.

UPDATE central_insights_sandbox.sho_nations_regions_homepage_regression
    SET is_north = CASE WHEN barb_region IN ('Yorkshire and Lincolnshire', 'North East and Cumbria', 'North West') THEN '1' ELSE '0' END;

UPDATE central_insights_sandbox.sho_nations_regions_homepage_regression
    SET is_london_barb = CASE WHEN barb_region = 'London'  THEN '1' ELSE '0' END;

UPDATE central_insights_sandbox.sho_nations_regions_homepage_regression
    SET is_south_barb = CASE WHEN barb_region IN ('South East', 'South', 'South West', 'West')  THEN '1' ELSE '0' END;

UPDATE central_insights_sandbox.sho_nations_regions_homepage_regression
    SET is_midlands =  CASE WHEN barb_region IN ('Midlands East', 'East of England', 'Midlands West') THEN '1' ELSE '0' END;

UPDATE central_insights_sandbox.sho_nations_regions_homepage_regression
    SET is_ni_barb = CASE WHEN barb_region = 'Ulster'  THEN '1' ELSE '0' END;

UPDATE central_insights_sandbox.sho_nations_regions_homepage_regression
    SET is_sct_barb = CASE WHEN barb_region = 'Scotland'  THEN '1' ELSE '0' END;

UPDATE central_insights_sandbox.sho_nations_regions_homepage_regression
    SET is_wal_barb = CASE WHEN barb_region = 'Wales'  THEN '1' ELSE '0' END;






















