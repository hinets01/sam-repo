--Step 1 - get core data set

CREATE TABLE central_insights_sandbox.sho_sticking_point_data
(
  bbc_hid3 VARCHAR(4000),
  version_id VARCHAR(4000) DISTKEY,
  series_id VARCHAR(4000),
  brand_id VARCHAR(4000),
  episode_id VARCHAR(4000),
  tleo VARCHAR(4000))
;

INSERT INTO central_insights_sandbox.sho_sticking_point_data
SELECT
    bbc_hid3,
    version_id_merge AS version_id,
    series_id_merge AS series_id,
    brand_id_merge AS brand_id,
    episode_id_merge AS episode_id,
    brand_id_merge || series_id_merge AS tleo
FROM central_insights.view_watch_daily_summary
WHERE date BETWEEN '2017-12-01' AND '2018-01-30'
  AND series_id_merge IN ('p05hgs13','p01fj945','b04kkm8q','b079vp14','b088s45m','p03kbqgf','p02gfy02','p02544td','p040tlqx','b006mywy','b076vdbc','p04qm31j',  'b00mfl7n','p04thlmg','p05lghr0','p05nd9j9','p05lvqql','b007lb93','b01k9pm3','b03vp2vy','b08l5tmp','b07500bw','b042r1dj','p03fvsd8','p05hvq5f','p01dmdcb','b0881dry','b00nzytf','p00w4b78','b00w7dtb','p05j1jvb','b0991bqh','p04qv4jc','b03tvq6m','b08ghppm','b05p655x','b007vvcq','p01djwdt','b08rgd67','p05bj88r','p00zdn1b','p04l7p22','b04d72g0','p03hbwq9','p00wg3f6','p05gl48m','p047lvcs','p014vls5')
  AND version_id_merge IS NOT NULL
  AND episode_id_merge IS NOT NULL
  AND version_id_merge != 'null'
  AND episode_id_merge != 'null'
GROUP BY bbc_hid3, version_id_merge, series_id_merge, brand_id_merge, episode_id_merge, tleo
;

--step 2 - join on metadata
CREATE TEMP TABLE sho_sticking_point_enriched
(
  bbc_hid3           VARCHAR(4000),
  version_id         VARCHAR(4000),
  series_id          VARCHAR(4000),
  brand_id           VARCHAR(4000),
  episode_id         VARCHAR(4000),
  tleo               VARCHAR(4000),
  episode_title      VARCHAR(4000),
  presentation_title VARCHAR(4000),
  series_title       VARCHAR(4000),
  brand_title        VARCHAR(4000),
  programme_title    VARCHAR(4000),
  concatenated_title VARCHAR(4000),
  bbc_st_pips        VARCHAR(4000)
);

-- INSERT INTO sho_sticking_point_enriched
INSERT INTO sho_sticking_point_enriched
SELECT
 DISTINCT central_insights_sandbox.sho_sticking_point_data.*,
  central_insights.programme_metadata.episode_title,
  central_insights.programme_metadata.presentation_title,
  central_insights.programme_metadata.series_title,
  central_insights.programme_metadata.brand_title,
  central_insights.programme_metadata.programme_title,
  central_insights.programme_metadata.concatenated_title,
  central_insights.programme_metadata.bbc_st_pips
FROM central_insights_sandbox.sho_sticking_point_data

join central_insights.programme_metadata
ON central_insights_sandbox.sho_sticking_point_data.version_id = central_insights.programme_metadata.version_id
;

--step 3 - add episode counts
CREATE TEMP TABLE sho_sticking_point_analysis

  AS

  WITH ep_count_lookup AS (
    SELECT tleo, episode_id
    FROM sho_sticking_point_enriched
      WHERE bbc_st_pips = 'episode'
    GROUP BY tleo, episode_id),

  ep_counts as
    (SELECT tleo, count from (select tleo, count(episode_id) OVER (PARTITION BY tleo) FROM ep_count_lookup)
    GROUP BY tleo, count)

SELECT
  sho_sticking_point_enriched.bbc_hid3,
  sho_sticking_point_enriched.version_id,
  sho_sticking_point_enriched.episode_id,
  sho_sticking_point_enriched.series_id,
  sho_sticking_point_enriched.brand_id,
  sho_sticking_point_enriched.tleo,
  sho_sticking_point_enriched.episode_title,
  sho_sticking_point_enriched.series_title,
  sho_sticking_point_enriched.brand_title,
  sho_sticking_point_enriched.concatenated_title,
  sho_sticking_point_enriched.programme_title,
  sho_sticking_point_enriched.bbc_st_pips,
  count(sho_sticking_point_enriched.episode_id) OVER (PARTITION BY sho_sticking_point_enriched.bbc_hid3, sho_sticking_point_enriched.series_id) AS eps_watched,
  ep_counts.count AS eps_available
FROM sho_sticking_point_enriched
JOIN ep_counts ON sho_sticking_point_enriched.tleo = ep_counts.tleo
WHERE bbc_st_pips = 'episode'
;

--step 4 - add completion flag
-- this could do with genre adding at some point

CREATE TABLE central_insights_sandbox.sho_sticking_point_aggregated
  AS
WITH sticking_point_final AS
(select
    sho_sticking_point_analysis.bbc_hid3,
    sho_sticking_point_analysis.version_id,
    sho_sticking_point_analysis.episode_id,
    sho_sticking_point_analysis.series_id,
    sho_sticking_point_analysis.brand_id,
    sho_sticking_point_analysis.tleo,
    sho_sticking_point_analysis.eps_watched,
    sho_sticking_point_analysis.eps_available,
    sho_sticking_point_analysis.episode_title,
    sho_sticking_point_analysis.series_title,
    sho_sticking_point_analysis.brand_title,
    sho_sticking_point_analysis.programme_title,
    sho_sticking_point_analysis.concatenated_title,

    CASE
      WHEN eps_watched = eps_available THEN TRUE
      ELSE FALSE
    END AS completion_flag

FROM sho_sticking_point_analysis)

SELECT
  concatenated_title,
  series_title,
  brand_title,
  programme_title,
  episode_id,
  count(CASE WHEN completion_flag = TRUE then bbc_hid3 END) as hids_that_completed,
  count(CASE WHEN completion_flag = FALSE then bbc_hid3 END) as hids_that_dropped_out

FROM sticking_point_final
  GROUP BY concatenated_title,series_title,brand_title,programme_title,episode_id
;

DROP TABLE central_insights_sandbox.sho_sticking_point_data;
DROP TABLE central_insights_sandbox.sho_sticking_point_enriched;
DROP TABLE central_insights_sandbox.sho_sticking_point_analysis;
DROP TABLE central_insights_sandbox.sho_sticking_point_aggregated;
DROP TABLE central_insights_sandbox.sho_sticking_point_final;