DROP TABLE IF EXISTS central_insights_sandbox.sho_completion_benchmarking;
CREATE TABLE central_insights_sandbox.sho_completion_benchmarking 
diststyle EVEN 
AS
SELECT 
       bbc_st_lod,
       bbc_st_pips,
       brand_id,
       brand_title,
       children,
       clip_id,
       clip_title,
       comedy,
       concatenated_title,
       drama,
       entertainment,
       episode_id,
       episode_title,
       factual,
       geo,
       learning,
       master_brand_id,
       master_brand_name,
       media_type,
       music,
       news,
       ns_v_platform,
       pips_genre_level_1_names,
       presentation_title,
       programme,
       religion,
       series_id,
       series_title,
       short_synopsis,
       sport,
       SUM(stream_completions_25) AS stream_completions_25,
       SUM(stream_completions_50) AS stream_completions_50,
       SUM(stream_completions_75) AS stream_completions_75,
       SUM(stream_completions_95) AS stream_completions_95,
       stream_length,
       SUM(stream_playing_time_unique) AS stream_playing_time_unique,
       SUM(stream_starts_min_3_secs) AS stream_starts_min_3_secs,
       weather,
       webcast_flag,
        
FROM central_insights_sandbox.aw_chatbot_ava_dataset
WHERE day > '20170101'
GROUP BY 
       app_type,
       bbc_st_lod,
       bbc_st_pips,
       brand_id,
       brand_title,
       children,
       clip_id,
       clip_title,
       comedy,
       concatenated_title,
       drama,
       entertainment,
       episode_id,
       episode_title,
       factual,
       geo,
       learning,
       master_brand_id,
       master_brand_name,
       media_type,
       music,
       news,
       ns_v_platform,
       pips_genre_level_1_names,
       presentation_title,
       programme,
       religion,
       series_id,
       series_title,
       short_synopsis,
       sport,
       stream_length,
       weather,
       webcast_flag
;

COMMIT;

alter table central_insights_sandbox.sho_completion_benchmarking
add column completion_rate int;
COMMIT;


