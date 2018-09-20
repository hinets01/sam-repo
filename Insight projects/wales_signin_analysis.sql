-- Wales sign-in analysis August 2018

-- get total all-time BBC accounts, split by nation.
SELECT
  nation,
  count(DISTINCT bbc_hid3)
  FROM prez.id_profile
GROUP BY
  nation
;

-- replicate leo's analysis for ID penetration by town, without the 10,000 population limit.

SET SEARCH_PATH = central_insights_sandbox;

CREATE TABLE sho_towns_staging
(
  town VARCHAR(100),
  nation VARCHAR(100),
  hid_count INT,
  population INT,
  bbc_id_pct DECIMAL(5,2)
)
;

INSERT INTO sho_towns_staging
WITH
  acorn AS (
    SELECT
      lookup.town,
      acorn.country AS nation,
      SUM(acorn.population) AS population
    FROM lt_201806_dt_postcode_town_lookup AS lookup
      INNER JOIN lt_201806_uk_acorn_postcode_directory_2018_district AS acorn
        ON lookup.postcode_district = acorn.postcode_district
    GROUP BY
      lookup.town,
      acorn.country
  ),
  profile AS (
    SELECT
      lookup.town,
      COUNT(DISTINCT profile.bbc_hid3) AS hid_count
    FROM lt_201806_dt_postcode_town_lookup AS lookup
      INNER JOIN prez.profile_extension AS profile
        ON lookup.postcode_district = profile.postcode_sector_adult_paf
    GROUP BY lookup.town
  )
SELECT
  profile.town,
  acorn.nation,
  profile.hid_count,
  acorn.population,
  1.00 * profile.hid_count / acorn.population AS bbc_id_pct
FROM acorn
  INNER JOIN profile
    ON acorn.town = profile.town
;


--join above town penetration with acorn proportion.
--!! needs to be finished and joined with above!!
--!! may need subquery to get acorn proportions of population or this may be easier in tableau

CREATE TABLE sho_nations_towns_analysis
AS
WITH
  acorn AS
  (
  SELECT
    lt_201806_dt_postcode_town_lookup.postcode_district,
    sum(CASE WHEN acorn_category = 1 THEN population END) AS acorn_cat_1_pop,
    sum(CASE WHEN acorn_category = 2 THEN population END) AS acorn_cat_2_pop,
    sum(CASE WHEN acorn_category = 3 THEN population END) AS acorn_cat_3_pop,
    sum(CASE WHEN acorn_category = 4 THEN population END) AS acorn_cat_4_pop,
    sum(CASE WHEN acorn_category = 5 THEN population END) AS acorn_cat_5_pop,
    sum(CASE WHEN acorn_category = 6 THEN population END) AS acorn_cat_6_pop,
    lt_201806_dt_postcode_town_lookup.town
  FROM lt_201806_uk_acorn_postcode_directory_2018_district
  JOIN lt_201806_dt_postcode_town_lookup ON lt_201806_uk_acorn_postcode_directory_2018_district.postcode_district = lt_201806_dt_postcode_town_lookup.postcode_district
  GROUP BY lt_201806_dt_postcode_town_lookup.postcode_district, town
  )
  ,
  acorn_proportion AS
  (
  SELECT
    town,
    sum(acorn_cat_1_pop) AS acorn_cat_1_pop,
    sum(acorn_cat_2_pop) AS acorn_cat_2_pop,
    sum(acorn_cat_3_pop) AS acorn_cat_3_pop,
    sum(acorn_cat_4_pop) AS acorn_cat_4_pop,
    sum(acorn_cat_5_pop) AS acorn_cat_5_pop,
    sum(acorn_cat_6_pop) AS acorn_cat_6_pop
  FROM acorn
  GROUP BY town
  )
 -- ,
  --staging AS
 -- (
SELECT
  sho_towns_staging.*,
  acorn_proportion.acorn_cat_1_pop,
  acorn_proportion.acorn_cat_2_pop,
  acorn_proportion.acorn_cat_3_pop,
  acorn_proportion.acorn_cat_4_pop,
  acorn_proportion.acorn_cat_5_pop,
  acorn_proportion.acorn_cat_6_pop
FROM sho_towns_staging
JOIN acorn_proportion ON sho_towns_staging.town = acorn_proportion.town
WHERE population NOTNULL
GROUP BY
  sho_towns_staging.town,
  nation,
  hid_count,
  population,
  bbc_id_pct,
  acorn_cat_1_pop,
  acorn_cat_2_pop,
  acorn_cat_3_pop,
  acorn_cat_4_pop,
  acorn_cat_5_pop,
  acorn_cat_6_pop
;

SELECT sum(population), acorn_category FROM central_insights_sandbox.lt_201806_uk_acorn_postcode_directory_2018_sector
WHERE postcode_sector LIKE 'NP10%' OR postcode_sector LIKE
'NP11%' OR postcode_sector LIKE 'NP18%' OR postcode_sector LIKE 'NP19%' OR postcode_sector LIKE 'NP20%'
GROUP BY acorn_category;


-- create table for National Statistics Lookup UK

SET SEARCH_PATH = central_insights_sandbox;
DROP TABLE IF EXISTS ons_postcode_NUTS_lookup;
CREATE TABLE ons_postcode_NUTS_lookup
(
  postcode1 VARCHAR(20) DISTKEY,
  postcode2 VARCHAR(20),
  postcode3 VARCHAR(20),
  date_introduced VARCHAR(20),
  user_type VARCHAR(10),
  easting VARCHAR(20),
  northing VARCHAR(20),
  positional_quality VARCHAR(20),
  county_code VARCHAR(50),
  county_name VARCHAR(100),
  local_authority_code VARCHAR(50),
  local_authority_name VARCHAR(100),
  ward_code VARCHAR(50),
  ward_name VARCHAR(100),
  country_code VARCHAR(50),
  country_name VARCHAR(50),
  region_code VARCHAR(50),
  region_name VARCHAR(100),
  parliament_const_code VARCHAR(50),
  parliament_const_name VARCHAR(100),
  eu_electoral_region_code VARCHAR(50),
  eu_electoral_region_name VARCHAR(100),
  primary_care_trust_code VARCHAR(100),
  primary_care_trust_name VARCHAR(100),
  lower_super_output_code VARCHAR(50),
  lower_super_output_name VARCHAR(100),
  middle_super_output_code VARCHAR(50),
  middle_super_output_name VARCHAR(100),
  output_area_class_code VARCHAR(20),
  output_area_class_names VARCHAR(150),
  longitude VARCHAR(20),
  latitude VARCHAR(20),
  spatial_accuracy VARCHAR(50),
  last_updated VARCHAR(20),
  location VARCHAR(100),
  socrata_id VARCHAR(50)
)
;
COMMIT;






















