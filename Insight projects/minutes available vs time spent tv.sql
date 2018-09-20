
DROP TABLE IF EXISTS central_insights_sandbox.sho_genre_minutes_tv_2018;
CREATE TABLE central_insights_sandbox.sho_genre_minutes_tv_2018
diststyle EVEN
AS
SELECT
    extract(MONTH FROM day) AS month_number,
    programme_title,
    concatenated_title,
    CASE WHEN pips_genre_level_1_names LIKE '%Children%' THEN 1 ELSE 0 END AS childrens,
    CASE WHEN pips_genre_level_1_names LIKE '%Comedy%' THEN 1 ELSE 0 END AS comedy,
    CASE WHEN pips_genre_level_1_names LIKE '%Drama%' THEN 1 ELSE 0 END AS drama,
    CASE WHEN pips_genre_level_1_names LIKE '%Entertainment%' THEN 1 ELSE 0 END AS entertainment,
    tleo_top_level_id,
    CASE WHEN pips_genre_level_1_names LIKE '%Factual%' THEN 1 ELSE 0 END AS factual,
    CASE WHEN pips_genre_level_1_names LIKE '%Learning%' THEN 1 ELSE 0 END AS learning,
    master_brand_name,
    media_type,
    CASE WHEN pips_genre_level_1_names LIKE '%Music%' THEN 1 ELSE 0 END AS music,
    CASE WHEN pips_genre_level_1_names LIKE '%News%' THEN 1 ELSE 0 END AS news,
    pips_genre_level_1_names,
    CASE WHEN pips_genre_level_1_names LIKE '%rReligion%' THEN 1 ELSE 0 END AS religion,
    CASE WHEN pips_genre_level_1_names LIKE '%Sport%' THEN 1 ELSE 0 END AS sport,
    stream_length,
    SUM(stream_playing_time_unique) AS stream_playing_time_unique,
    SUM(stream_starts_min_3_secs) AS stream_starts_min_3_secs,
    CASE WHEN pips_genre_level_1_names LIKE '%Weather%' THEN 1 ELSE 0 END AS weather
FROM central_insights_sandbox.aw_ava_join
WHERE clip_id ISNULL and media_type = 'video' and master_brand_name in ('BBC One', 'BBC Two', 'BBC Three', 'BBC Four', 'CBBC', 'CBeebies', 'BBC Sport', 'BBC News', 'BBC News Channel', 'BBC Music', 'BBC One Wales', 'BBC One Scotland', 'BBC One Northern Ireland', 'BBC Parliament', 'S4C', 'BBC Two Wales', 'BBC World News', 'BBC ALBA', 'BBC Two Scotland', 'BBC Two Northern Ireland', 'BBC Arts', 'Shakespeareâ¤?s Globe', 'Hay Festival')
and day between '2017-04-01' and '2018-03-31'
and geo = 'UK Territory'
GROUP BY
    month_number,
    programme_title,
    concatenated_title,
    childrens,
    comedy,
    drama,
    entertainment,
    tleo_top_level_id,
    factual,
    learning,
    master_brand_name,
    media_type,
    music,
    news,
    pips_genre_level_1_names,
    religion,
    sport,
    stream_length,
    weather
;

COMMIT;

SELECT DISTINCT month_number
FROM central_insights_sandbox.sho_genre_minutes_tv_2018;