--step 1 - create table of all playing times per hid from csactivityview, joined with programme metadata. Convert episode duration to mins and add full title as concatenation of metadata fields.
drop table if exists central_insights_sandbox.sho_episode_dropout;

CREATE TABLE central_insights_sandbox.sho_episode_dropout
diststyle EVEN
AS
Select 
    csactivityview.bbc_hid3, 
    csactivityview.ns_v_platform,
    csactivityview.ns_st_pt,
    cast(csactivityview.cal_yyyymmdd AS DATE),
    central_insights.programme_metadata.brand_id,
    central_insights.programme_metadata.episode_id,
    central_insights.programme_metadata.brand_title,
    central_insights.programme_metadata.series_title,
    central_insights.programme_metadata.episode_title,
    central_insights.programme_metadata.presentation_title,
    central_insights.programme_metadata.bbc_st_pips,
    central_insights.programme_metadata.single_duration / 60 as duration_mins,
    central_insights.programme_metadata.master_brand_name,
    central_insights.programme_metadata.brand_title || ',' || central_insights.programme_metadata.series_title || ',' || central_insights.programme_metadata.episode_title || ',' || central_insights.programme_metadata.presentation_title  as full_title
from prez.csactivityview 
join central_insights.programme_metadata on csactivityview.version_id = central_insights.programme_metadata.version_id
    where prez.csactivityview.cal_yyyymmdd between '20170925' and '20171025'
    AND central_insights.programme_metadata.bbc_st_pips = 'episode' 
    AND prez.csactivityview.version_id IS NOT NULL
    AND prez.csactivityview.ns_st_pt IS NOT NULL
    AND central_insights.programme_metadata.master_brand_name in ('BBC One', 'BBC Two', 'BBC Three', 'BBC Four')
    --AND prez.csactivityview.bbc_st_lod = 'on-demand'
;


--step 2 - join the first table with id profile demographics. Filter out very long playing times and convert to mins.
drop table if exists central_insights_sandbox.sho_episode_dropout_demogs;

CREATE TABLE central_insights_sandbox.sho_episode_dropout_demogs
diststyle EVEN 
AS
Select 
      central_insights_sandbox.sho_episode_dropout.bbc_hid3,
      central_insights_sandbox.sho_episode_dropout.ns_v_platform,
      central_insights_sandbox.sho_episode_dropout.ns_st_pt / 60000 as playing_time_mins,
      central_insights_sandbox.sho_episode_dropout.cal_yyyymmdd,
      central_insights_sandbox.sho_episode_dropout.brand_id,
      central_insights_sandbox.sho_episode_dropout.episode_id,
      central_insights_sandbox.sho_episode_dropout.brand_title,
      central_insights_sandbox.sho_episode_dropout.series_title,
      central_insights_sandbox.sho_episode_dropout.episode_title,
      central_insights_sandbox.sho_episode_dropout.presentation_title,
      central_insights_sandbox.sho_episode_dropout.duration_mins,
      central_insights_sandbox.sho_episode_dropout.master_brand_name,
      central_insights_sandbox.sho_episode_dropout.full_title,
      prez.profile_extension.barb_region,
      prez.profile_extension.nation,
      prez.profile_extension.gender,
      prez.profile_extension.age_range
from central_insights_sandbox.sho_episode_dropout

join prez.profile_extension on sho_episode_dropout.bbc_hid3 = prez.profile_extension.bbc_hid3

where central_insights_sandbox.sho_episode_dropout.ns_st_pt > '0'
and LEN(central_insights_sandbox.sho_episode_dropout.ns_st_pt) < '15'
;

--step 3 - calculate maximum ns_st_pt value for each hid - this is the completion rate. Filter out any playing times that exceed duration of content.
drop table if exists central_insights_sandbox.sho_episode_dropout_minute_completion;

create table central_insights_sandbox.sho_episode_dropout_minute_completion
diststyle EVEN
AS
Select  
    age_range, 
    barb_region, 
    bbc_hid3,
    brand_title,
    series_title,  
    episode_title,
    presentation_title,
    full_title,
    episode_id, 
    gender, 
    nation, 
    ns_v_platform, 
    duration_mins,    
    max(playing_time_mins) over (partition by bbc_hid3 || full_title) as completion_minutes
    
from central_insights_sandbox.sho_episode_dropout_demogs
 
where playing_time_mins <= duration_mins
;

--step4 - summarise the data to give total hids that dropped out of each piece of content by minute. This table now ready for analysis.
drop table if exists central_insights_sandbox.sho_episode_dropout_analysis;

create table central_insights_sandbox.sho_episode_dropout_analysis
diststyle EVEN
AS
select 
    count (distinct bbc_hid3) as total_hids,
    age_range,
    barb_region,
    brand_title,
    series_title, 
    episode_title,
    presentation_title,
    full_title,
    episode_id,
    gender, 
    nation, 
    round(completion_minutes) as minute_reached,
    duration_mins     
from central_insights_sandbox.sho_episode_dropout_minute_completion

group by 
    age_range, 
    barb_region, 
    completion_minutes,
    brand_title,
    series_title,  
    episode_title,
    presentation_title,
    full_title,
    episode_id, 
    gender, 
    nation, 
    minute_reached, 
    duration_mins
;
COMMIT;

drop table central_insights_sandbox.sho_episode_dropout;
drop table central_insights_sandbox.sho_episode_dropout_demogs;
drop table central_insights_sandbox.sho_episode_dropout_minute_completion;

COMMIT;
