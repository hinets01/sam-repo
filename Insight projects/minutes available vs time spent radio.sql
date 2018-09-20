
DROP TABLE IF EXISTS central_insights_sandbox.sho_genre_minutes_tv_2018;
CREATE TABLE central_insights_sandbox.sho_genre_minutes_tv_2018
diststyle EVEN
AS
SELECT
       extract(WEEK FROM day) AS week_number,
       brand_title,
       bbc_st_lod as live_or_ondemand,
       children,
       comedy,
       concatenated_title,
       drama,
       entertainment,
       episode_id,
       episode_title,
       factual,
       geo,
       learning,
       master_brand_name,
       media_type,
       music,
       news,
       pips_genre_level_1_names,
       presentation_title,
       top_level_title,
       religion,
       series_title,
       sport,
       stream_length,
       SUM(stream_playing_time_unique) AS stream_playing_time_unique,
       SUM(stream_starts_min_3_secs) AS stream_starts_min_3_secs,
       weather,
       webcast_flag
FROM central_insights.ava_episode_clip
WHERE bbc_st_pips = 'episode' and media_type = 'video' and master_brand_name in ('BBC One', 'BBC Two', 'BBC Three', 'BBC Four', 'CBBC', 'CBeebies', 'BBC Sport', 'BBC News', 'BBC News Channel', 'BBC Music', 'BBC One Wales', 'BBC One Scotland', 'BBC One Northern Ireland', 'BBC Parliament', 'S4C', 'BBC Two Wales', 'BBC World News', 'BBC ALBA', 'BBC Two Scotland', 'BBC Two Northern Ireland', 'BBC Arts', 'Shakespeareâ¤?s Globe', 'Hay Festival')
and day between '2017-01-01' and '2017-12-31'
and geo = 'UK Territory'
GROUP BY
       week_number,
       brand_title,
       live_or_ondemand,
       children,
       comedy,
       concatenated_title,
       drama,
       entertainment,
       episode_id,
       episode_title,
       factual,
       geo,
       learning,
       master_brand_name,
       media_type,
       music,
       news,
       pips_genre_level_1_names,
       presentation_title,
       top_level_title,
       religion,
       series_title,
       sport,
       stream_length,
       weather,
       webcast_flag
       ;

COMMIT;

