DROP TABLE IF EXISTS central_insights_sandbox.sho_sticking_point_radio_od;
CREATE TABLE central_insights_sandbox.sho_sticking_point_radio_od
  (
  bbc_hid3 VARCHAR(4000),
  version_id VARCHAR(4000) DISTKEY,
  series_id VARCHAR(4000),
  brand_id VARCHAR(4000),
  episode_id VARCHAR(4000),
  tleo VARCHAR(4000))
;
INSERT INTO central_insights_sandbox.sho_sticking_point_radio_od
  SELECT
  bbc_hid3,
  version_id_merge AS version_id,
  series_id_merge AS series_id,
  brand_id_merge AS brand_id,
  episode_id_merge AS episode_id,
  brand_id_merge || series_id_merge AS tleo
FROM central_insights.view_watch_daily_summary
WHERE date BETWEEN '2017-07-01' AND '2018-05-30'
  AND version_id_merge IS NOT NULL
  AND episode_id_merge IS NOT NULL
  AND version_id_merge != 'null'
  AND episode_id_merge != 'null'
  AND bbc_st_lod = 'on-demand'
  AND series_id_merge IN ('b09m370r', 'b0769mfr', 'b09tn71f', 'b09lsnnr', 'b097n5h5', 'b09vgg3m', 'b01p7qyj', 'b092z8t2', 'b09jgkcr', 'b09xctjy', 'b08try24', 'b09707kn', 'b08w92p7', 'b09kqr5m', 'b09m4yyp', 'b09wph38', 'b0916db9', 'b09pw49z', 'b0991r5j', 'b0b3qvhd', 'b090rfng', 'b09t8b60', 'b01mk30y', 'b09t89gc', 'b09vgdd1', 'b0921c39', 'b09cdt04', 'b01sk4r8', 'b09ysq7c', 'b0b228gf', 'b09b6348', 'b0b1qll0', 'b09x9kw9', 'b06sq6jc', 'b09yxk27', 'b08z82vc', 'b08zrdf8', 'b01mdbrq', 'b09d9qgn', 'b09vfbdn', 'b09f8rcq', 'b09hmxc1', 'b06t2gh6', 'b0998lqj', 'b040ln40', 'b09pz5lf', 'b092st3k', 'b09g0d05', 'b0b45175', 'b08w4tk6', 'b09rtd9s', 'b07w0ftm', 'b09mscbr', 'b09cdv57', 'b0b15bcw', 'b09706s2', 'b0b0b6k2', 'b08vfkzp', 'b09xy93q', 'b0b2lk93', 'b00qzskp', 'b08llqhj', 'b03b7p77', 'b09kdm7j', 'b08x0g7p', 'b04x6xm1', 'b097l4vn', 'b09h2q8x', 'b0b4zx3t', 'b03nv05z', 'b092z069', 'b092qjfg', 'b09f8j5f', 'b095byv1', 'b09f3l1r', 'b01hj76t', 'p06080gh', 'b090rb6d', 'b08qhxvm', 'b09ysjgz', 'b0962b77', 'b0957n0m', 'b09pywh0', 'b09hmvfl', 'b09ypxct', 'b06jltst', 'b09h0hl0', 'b09br24w', 'b09ypx3n', 'b09lsp2x', 'b08w93wl', 'b0214pvz', 'b09g43n5', 'b03xkpv3', 'b09s787v', 'b08llksd', 'b07ptgh5', 'b01p53h9', 'b04wz81v', 'b01n8jdn', 'b094f4gs', 'b08nwtkp', 'b03f0lxl', 'b04dr3q7', 'b01pmc26', 'b05y97qz', 'b04lhh4s', 'b00k87g8', 'b04y6xvk', 'b007llps', 'b07wzzz6', 'b07wr1v2', 'b04ww1pg', 'b08t08fv', 'b008cxyb', 'b078j08t', 'b08sw64s', 'b054yj22', 'b0b56z44', 'b01rrzth', 'b037kydx', 'b03yrln9', 'b03vq1ss', 'b019m1d6', 'b03qgsw8', 'b01npfrr', 'b0485xw9', 'b03p8sls', 'b03xl5df', 'b08rmklb', 'b08vkm52', 'b09t88q3', 'b09qrj3g', 'b09fc4qj', 'b0906s5g', 'b09lsns0', 'b0949h54', 'b092sx27', 'b09lym4z', 'b095mkc4', 'b09m4x0y', 'b08f0kqs', 'b096kytj', 'b092qjvb', 'b067gcj6', 'b09xy8bp', 'b09g5f6z', 'b090rrl2', 'b09bqyp7', 'b07w1dpx', 'b09kg57n', 'b08s46tk', 'b09pyvmw', 'b09l90ml', 'b08svvgx', 'b09svkpp', 'b00ls8ll', 'b0998kll', 'b095c2vq', 'b09jhv6q', 'b09pyrsz', 'b0864482', 'b09sjsry', 'b0911wqt', 'b09m2bnr', 'b09gnqp2', 'b08w9688', 'b07hjcz5', 'b08zbxmh', 'b096dh32', 'b0962xqf', 'b09v3gwm', 'b0911ymz', 'b0953zyy', 'b07ktd7x', 'b091fpx4', 'b09qwb65', 'b07yvtm3', 'b09f8lcm', 'b09t86q9', 'b08zbf23', 'b07pkg6b', 'b06rll2w', 'b00srz5b', 'b09lyrm6', 'b095705c', 'b0b02vhg', 'b09ysnw5', 'b09g3px0', 'b08x0gdj', 'b097l8xx', 'b08w58z1', 'b0916lcd', 'b09lwjfl', 'b09t8bt7', 'b09jhw5q', 'b08xzm2m', 'b01rv1wv', 'b09m3d5b', 'b09br47p', 'b09cft8p', 'b08z9kgm', 'b08rcm5v', 'b08p31n3', 'b03trmq3', 'b08t185q', 'b0953n80', 'b08mkhd5', 'b09fb6v2', 'b09vl40v', 'b09kbmrh', 'b09jn0ly', 'b053m865', 'b06qdbr9', 'b0b2jqmx', 'b00t6yj9', 'b060fks7', 'b062x6m6', 'b09s0h68', 'b09mt7fv', 'b072nhsd', 'b08x1qy6', 'b08w2dyl', 'b03jywcs', 'b09m7l0g', 'b00f84mt', 'b0b3v54q', 'b01p0rl9', 'b092sfrz', 'b04vd0nr', 'b08yn8ff', 'b083vq05', 'b00vys24', 'b061r42d', 'b04pbwqj', 'b00w7k86', 'b08t15mf', 'b06bqtkd', 'b06br4f4', 'b09v3gwm', 'b00hpm38', 'b06kx6kg', 'b09163st', 'b06bpn9q', 'b098phk8', 'b0b2nxys', 'b0953vdz', 'b08wzbz5', 'b04g6y0r', 'b09yvkt0', 'b01q9tbk', 'b036wvkp', 'b07gm32h', 'b08s3sqz', 'b043x70b', 'b09gr2p5', 'b06t63d2', 'b04cgq4g', 'b08xx830', 'b03ggp49', 'b09xctlb', 'b04v98w8', 'b0729xtf', 'b09t86lr', 'b084fsfq', 'b039vjb1', 'b0953zj8', 'b01qzcvv', 'b09blc8w', 'b09q1bvr', 'b00cwgtc', 'b092st7l', 'b04gyp85', 'b092f45d', 'b01qllhl', 'b087b9qx', 'b05v4czn', 'b08g0170', 'b06b83wg', 'b08x94mx', 'b05xpyzw', 'b09xqj52', 'b01bw531', 'b09vl3qp', 'b04yc2dc', 'b0b0yc51', 'b097ml3n', 'b01cp16j', 'b09bwf8z', 'b09dj2wf', 'b09tbxwv', 'b039p5ws', 'b01mk989', 'b088nzc1', 'b0721287', 'b08w53jr', 'b0436r3b', 'b043j8x2', 'b0403v0g', 'b098sf3q', 'b03ybqtv', 'b09vm093', 'b074wwd0', 'b04knt4h', 'b08xrqns', 'b03y0hqc', 'b03zqn53', 'b03v351j', 'b09jhp7p', 'b08xrk9t', 'b09m3cg6', 'b08bgztl', 'b06bqctk', 'b009z2ds', 'b04kpx00', 'b084fr6p', 'b07nsf2x', 'b011g97z', 'b09k9jhx', 'b049fgbc', 'b02xb2v8', 'b04c9s85', 'b097lb2s', 'b09t89cb', 'b088tzkv', 'b08t3bwh', 'b0b01lcy', 'b08zqr1q', 'w27vpwq4', 'p058w7dp', 'b007d6gv', 'b036tc67', 'b013sqmg', 'b0949879', 'b09tc6rp', 'b00crrh8', 'b09bbg27', 'b01s2kcr', 'b07b2xxw', 'b00fjc2k', 'b00ft3yx', 'b00f6gsd', 'b063m8h9', 'b00c1xwl', 'b0990q7w', 'b017gq53', 'b00wls5y', 'b00bz65t', 'b00dn9rl', 'b00b98d4', 'b077rlyw', 'b068b5jj', 'b00nnrh6', 'b041xzzn', 'b01p7bqh', 'b00vvwv9', 'b01q0hvz', 'b00fgszb', 'b01jrshp', 'b00cftjq', 'b00cwpvn', 'b00h4r36', 'b00dpyg1', 'b009sm39', 'b00g4839', 'b00b5r2q', 'b010ns42', 'b00cjzpf', 'b00fsxp4', 'b00lcmc0', 'b00dzlrm', 'b07g8nnl', 'b00dm1pz', 'b00kkg1m', 'b068sfwx', 'b098ssf8', 'b00xgp3j', 'b07j8jnq', 'b00b5lq5', 'b00hkbrw', 'b048z181', 'b00d4xlc', 'b00fyjyz', 'b009sm1v', 'b09jc47h', 'b00czgtq', 'b00m3y0q', 'b00y9y8y', 'b02x5kph', 'b08yntkz', 'b00lb6f2', 'b09hx1pg', 'b00x18hm', 'b08x1r3t', 'b0072vcc', 'b00pfmfr', 'b0153s4w', 'b06rv3dt', 'b08yr378', 'b00crcw3', 'b00bg37x', 'b00clvm5', 'b00f850k', 'b08z8wyy', 'b09tx1f2', 'b00jkhh3', 'b09g4bdr', 'b09xsqbk', 'b00dxjz5', 'b01jhxdt', 'b00rd8z5', 'b053lhjf', 'b092g6x7', 'b09ms3kb', 'b0948qlh', 'b01l02f9', 'b0126c1d', 'b0b04vqg', 'b01nm1s0', 'b00fr23f', 'b00fgs8s', 'b00m6bbs', 'b009twjj', 'b007d9xl', 'b00gd4tg', 'b08n274n', 'b09qr7q7', 'b00p6rc4', 'b050gvz4', 'b04t74cm', 'b0949j8y', 'b05yy7ts', 'b00dpz3s', 'b00lmcx6', 'b012rxql', 'b012fc02', 'b00bzrjc', 'b00crn22', 'b007d637', 'b00sg0yk', 'b00f6m22', 'b00w8hsk', 'b009v2dy', 'b07dx2t3', 'b00ffnsz', 'b00xn6t8', 'b04411q0', 'b00ss2xd', 'b00v9ltp', 'b00fq43l', 'b00jg7wt', 'b03np5nk', 'b006qxtr', 'b00ngz51', 'b039tnfc', 'b05syhzr', 'b00cg0md', 'b00c8r8k', 'b00bg34c', 'b01s70x4', 'b00cjnm4', 'b011379w', 'b00np1nz', 'b00tq38j', 'b09hmt04', 'b00cnw4v', 'b0072v5l', 'b0129sbz', 'b0071prw', 'b00c4n68', 'b00ffl7c', 'b09hqmc1', 'b00tdmgf', 'b00wh4n3', 'b09m4zhp', 'b00czhbq', 'b01b20s1', 'b00h33ht', 'b00f1p74', 'b00lwdz7', 'b00sp45b', 'b0080fnj', 'b03b3cd0', 'b00fq3cf', 'b09xtwjz', 'b00h4wb5', 'b00fqhf2', 'b09mrq21', 'b00qtmqq', 'b06hcbvs', 'b006vn7f')
GROUP BY bbc_hid3, version_id_merge, series_id_merge, brand_id_merge, episode_id_merge, tleo
;

ALTER TABLE central_insights_sandbox.sho_sticking_point_radio_od
    ADD COLUMN ep_number INT;

UPDATE central_insights_sandbox.sho_sticking_point_radio_od
    SET ep_number = central_insights_sandbox.episode_numbers.episode_number
FROM central_insights_sandbox.episode_numbers
WHERE central_insights_sandbox.sho_sticking_point_radio_od.version_id = central_insights_sandbox.episode_numbers.version_id;

DROP TABLE IF EXISTS central_insights_sandbox.sho_sticking_point_radio_od_enriched;
CREATE TABLE central_insights_sandbox.sho_sticking_point_radio_od_enriched
(
  bbc_hid3           VARCHAR(4000),
  version_id         VARCHAR(4000),
  series_id          VARCHAR(4000),
  brand_id           VARCHAR(4000),
  episode_id         VARCHAR(4000),
  tleo               VARCHAR(4000),
  ep_number          INT,
  episode_title      VARCHAR(4000),
  presentation_title VARCHAR(4000),
  series_title       VARCHAR(4000),
  brand_title        VARCHAR(4000),
  programme_title    VARCHAR(4000),
  concatenated_title VARCHAR(4000),
  bbc_st_pips        VARCHAR(4000),
  master_brand_name VARCHAR(4000),
  pips_genre_level_1 VARCHAR(4000)
);

-- INSERT INTO sho_sticking_point_enriched
INSERT INTO central_insights_sandbox.sho_sticking_point_radio_od_enriched
SELECT
 DISTINCT central_insights_sandbox.sho_sticking_point_radio_od.*,
  central_insights.programme_metadata.episode_title,
  central_insights.programme_metadata.presentation_title,
  central_insights.programme_metadata.series_title,
  central_insights.programme_metadata.brand_title,
  central_insights.programme_metadata.programme_title,
  central_insights.programme_metadata.concatenated_title,
  central_insights.programme_metadata.bbc_st_pips,
  central_insights.programme_metadata.master_brand_name,
  central_insights.programme_metadata.pips_genre_level_1_names
FROM central_insights_sandbox.sho_sticking_point_radio_od

join central_insights.programme_metadata
ON central_insights_sandbox.sho_sticking_point_radio_od.version_id = central_insights.programme_metadata.version_id
;

DELETE FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched
WHERE bbc_st_pips = 'clip';




/* Episode 1 Viewers */

CREATE TEMP TABLE ep1_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep1_viewers
SELECT bbc_hid3, programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched
WHERE ep_number = '1'
AND bbc_st_pips = 'episode';

/* Episode 2 Viewers */

CREATE TEMP TABLE ep2_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep2_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep1_viewers ON ep1_viewers.bbc_hid3 = sp.bbc_hid3 AND ep1_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '2'
AND bbc_st_pips = 'episode';

/* Episode 3 Viewers */

CREATE TEMP TABLE ep3_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep3_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep2_viewers ON ep2_viewers.bbc_hid3 = sp.bbc_hid3 AND ep2_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '3'
AND bbc_st_pips = 'episode';

/* Episode 4 Viewers */

CREATE TEMP TABLE ep4_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep4_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep3_viewers ON ep3_viewers.bbc_hid3 = sp.bbc_hid3 AND ep3_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '4'
AND bbc_st_pips = 'episode';

/* Episode 5 Viewers */

CREATE TEMP TABLE ep5_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep5_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep4_viewers ON ep4_viewers.bbc_hid3 = sp.bbc_hid3 AND ep4_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '5'
AND bbc_st_pips = 'episode';

/* Episode 6 Viewers */

CREATE TEMP TABLE ep6_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep6_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep5_viewers ON ep5_viewers.bbc_hid3 = sp.bbc_hid3 AND ep5_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '6'
AND bbc_st_pips = 'episode';

/* Episode 7 Viewers */

CREATE TEMP TABLE ep7_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep7_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep6_viewers ON ep6_viewers.bbc_hid3 = sp.bbc_hid3 AND ep6_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '7'
AND bbc_st_pips = 'episode';

/* Episode 8 Viewers */

CREATE TEMP TABLE ep8_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep8_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep7_viewers ON ep7_viewers.bbc_hid3 = sp.bbc_hid3 AND ep7_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '8'
AND bbc_st_pips = 'episode';

/* Episode 9 Viewers */

CREATE TEMP TABLE ep9_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep9_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep8_viewers ON ep8_viewers.bbc_hid3 = sp.bbc_hid3 AND ep8_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '9'
AND bbc_st_pips = 'episode';

/* Episode 10 Viewers */

CREATE TEMP TABLE ep10_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep10_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep9_viewers ON ep9_viewers.bbc_hid3 = sp.bbc_hid3 AND ep9_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '10'
AND bbc_st_pips = 'episode';

/* Episode 11 Viewers */

CREATE TEMP TABLE ep11_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep11_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep10_viewers ON ep10_viewers.bbc_hid3 = sp.bbc_hid3 AND ep10_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '11'
AND bbc_st_pips = 'episode';

CREATE TEMP TABLE ep12_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep12_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep11_viewers ON ep11_viewers.bbc_hid3 = sp.bbc_hid3 AND ep11_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '12'
AND bbc_st_pips = 'episode';

CREATE TEMP TABLE ep13_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep13_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep12_viewers ON ep12_viewers.bbc_hid3 = sp.bbc_hid3 AND ep12_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '13'
AND bbc_st_pips = 'episode';

CREATE TEMP TABLE ep14_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep14_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep13_viewers ON ep13_viewers.bbc_hid3 = sp.bbc_hid3 AND ep13_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '14'
AND bbc_st_pips = 'episode';

CREATE TEMP TABLE ep15_viewers
(
  bbc_hid3          VARCHAR(100),
  programme_title   VARCHAR(100)
);

INSERT INTO ep15_viewers
SELECT sp.bbc_hid3, sp.programme_title
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched AS sp
INNER JOIN ep14_viewers ON ep14_viewers.bbc_hid3 = sp.bbc_hid3 AND ep14_viewers.programme_title = sp.programme_title
WHERE sp.ep_number = '15'
AND bbc_st_pips = 'episode';

/* TIME UPDATE: Approx 1 minute */

/* Create table: Part 1 */

CREATE TABLE central_insights_sandbox.sho_stickingpoint_complete_od AS

  WITH e1 AS
  (SELECT ep1.programme_title, COUNT(DISTINCT bbc_hid3) AS ep1viewers
  FROM ep1_viewers AS ep1
  GROUP BY ep1.programme_title),

  e2 AS
  (SELECT ep2.programme_title, COUNT(DISTINCT bbc_hid3) AS ep2viewers
  FROM ep2_viewers AS ep2
  GROUP BY ep2.programme_title),

  e3 AS
  (SELECT ep3.programme_title, COUNT(DISTINCT bbc_hid3) AS ep3viewers
  FROM ep3_viewers AS ep3
  GROUP BY ep3.programme_title),

  e4 AS
  (SELECT ep4.programme_title, COUNT(DISTINCT bbc_hid3) AS ep4viewers
  FROM ep4_viewers AS ep4
  GROUP BY ep4.programme_title),

  e5 AS
  (SELECT ep5.programme_title, COUNT(DISTINCT bbc_hid3) AS ep5viewers
  FROM ep5_viewers AS ep5
  GROUP BY ep5.programme_title),

  e6 AS
  (SELECT ep6.programme_title, COUNT(DISTINCT bbc_hid3) AS ep6viewers
  FROM ep6_viewers AS ep6
  GROUP BY ep6.programme_title),

  e7 AS
  (SELECT ep7.programme_title, COUNT(DISTINCT bbc_hid3) AS ep7viewers
  FROM ep7_viewers AS ep7
  GROUP BY ep7.programme_title),

  e8 AS
  (SELECT ep8.programme_title, COUNT(DISTINCT bbc_hid3) AS ep8viewers
  FROM ep8_viewers AS ep8
  GROUP BY ep8.programme_title),

  e9 AS
  (SELECT ep9.programme_title, COUNT(DISTINCT bbc_hid3) AS ep9viewers
  FROM ep9_viewers AS ep9
  GROUP BY ep9.programme_title),

  e10 AS
  (SELECT ep10.programme_title, COUNT(DISTINCT bbc_hid3) AS ep10viewers
  FROM ep10_viewers AS ep10
  GROUP BY ep10.programme_title),

  e11 AS
  (SELECT ep11.programme_title, COUNT(DISTINCT bbc_hid3) AS ep11viewers
  FROM ep11_viewers AS ep11
  GROUP BY ep11.programme_title),

  e12 AS
  (SELECT ep12.programme_title, COUNT(DISTINCT bbc_hid3) AS ep12viewers
  FROM ep12_viewers AS ep12
  GROUP BY ep12.programme_title),

  e13 AS
  (SELECT ep13.programme_title, COUNT(DISTINCT bbc_hid3) AS ep13viewers
  FROM ep13_viewers AS ep13
  GROUP BY ep13.programme_title),

  e14 AS
  (SELECT ep14.programme_title, COUNT(DISTINCT bbc_hid3) AS ep14viewers
  FROM ep14_viewers AS ep14
  GROUP BY ep14.programme_title),

  e15 AS
  (SELECT ep15.programme_title, COUNT(DISTINCT bbc_hid3) AS ep15viewers
  FROM ep15_viewers AS ep15
  GROUP BY ep15.programme_title)

  /* Create Table: Part 2 */

  SELECT e1.programme_title, e1.ep1viewers, e2.ep2viewers, e3.ep3viewers, e4.ep4viewers, e5.ep5viewers,
  e6.ep6viewers, e7.ep7viewers, e8.ep8viewers, e9.ep9viewers, e10.ep10viewers, e11.ep11viewers, e12.ep12viewers, e13.ep13viewers, e14.ep14viewers, e15.ep15viewers
  FROM e1
  LEFT JOIN e2 ON e1.programme_title = e2.programme_title
  LEFT JOIN e3 ON e2.programme_title = e3.programme_title
  LEFT JOIN e4 ON e3.programme_title = e4.programme_title
  LEFT JOIN e5 ON e4.programme_title = e5.programme_title
  LEFT JOIN e6 ON e5.programme_title = e6.programme_title
  LEFT JOIN e7 ON e6.programme_title = e7.programme_title
  LEFT JOIN e8 ON e7.programme_title = e8.programme_title
  LEFT JOIN e9 ON e8.programme_title = e9.programme_title
  LEFT JOIN e10 ON e9.programme_title = e10.programme_title
  LEFT JOIN e11 ON e10.programme_title = e11.programme_title
  LEFT JOIN e12 ON e11.programme_title = e12.programme_title
  LEFT JOIN e13 ON e12.programme_title = e13.programme_title
  LEFT JOIN e14 ON e13.programme_title = e14.programme_title
  LEFT JOIN e15 ON e14.programme_title = e15.programme_title;

/* Drop temp tables */

DROP TABLE ep1_viewers;
DROP TABLE ep2_viewers;
DROP TABLE ep3_viewers;
DROP TABLE ep4_viewers;
DROP TABLE ep5_viewers;
DROP TABLE ep6_viewers;
DROP TABLE ep7_viewers;
DROP TABLE ep8_viewers;
DROP TABLE ep9_viewers;
DROP TABLE ep10_viewers;
DROP TABLE ep11_viewers;
DROP TABLE ep12_viewers;
DROP TABLE ep13_viewers;
DROP TABLE ep14_viewers;
DROP TABLE ep15_viewers;

-- update enriched table and add age ranges in order to get profile for each series
-- this will only take into account age skew of those who STARTED the series, not average of series overall.
ALTER TABLE central_insights_sandbox.sho_sticking_point_od_enriched
  ADD COLUMN age_range VARCHAR(400)
;

UPDATE central_insights_sandbox.sho_sticking_point_od_enriched
  SET age_range = prez.profile_extension.age_range
  FROM prez.profile_extension
  WHERE central_insights_sandbox.sho_sticking_point_od_enriched.bbc_hid3 = prez.profile_extension.bbc_hid3
;

-- get proportion of under-35s

WITH
    ages AS
  (SELECT programme_title, age_range, count(DISTINCT bbc_hid3) AS total_hids
  FROM central_insights_sandbox.sho_sticking_point_extra_series
  GROUP BY programme_title, age_range)

SELECT
  programme_title,
  sum(CASE WHEN age_range IN ('16-19','20-24','25-29','30-34') THEN total_hids ELSE 0 END ) AS under_35s,
  sum(CASE WHEN age_range IN ('35-39','40-44','45-49','50-54','55-59','60-64','65-70','>70') THEN total_hids ELSE 0 END) AS over_35s
FROM ages
GROUP BY programme_title
;

SELECT programme_title, genres_list_a_names, genres_list_b_names, genres_list_c_names, genres_list_d_names, pips_genre_level_1_names, pips_genre_level_2_names, avg(programme_duration)   FROM central_insights.programme_metadata
WHERE series_id IN ('b09m370r', 'b0769mfr', 'b09tn71f', 'b09lsnnr', 'b097n5h5', 'b09vgg3m', 'b01p7qyj', 'b092z8t2', 'b09jgkcr', 'b09xctjy', 'b08try24', 'b09707kn', 'b08w92p7', 'b09kqr5m', 'b09m4yyp', 'b09wph38', 'b0916db9', 'b09pw49z', 'b0991r5j', 'b0b3qvhd', 'b090rfng', 'b09t8b60', 'b01mk30y', 'b09t89gc', 'b09vgdd1', 'b0921c39', 'b09cdt04', 'b01sk4r8', 'b09ysq7c', 'b0b228gf', 'b09b6348', 'b0b1qll0', 'b09x9kw9', 'b06sq6jc', 'b09yxk27', 'b08z82vc', 'b08zrdf8', 'b01mdbrq', 'b09d9qgn', 'b09vfbdn', 'b09f8rcq', 'b09hmxc1', 'b06t2gh6', 'b0998lqj', 'b040ln40', 'b09pz5lf', 'b092st3k', 'b09g0d05', 'b0b45175', 'b08w4tk6', 'b09rtd9s', 'b07w0ftm', 'b09mscbr', 'b09cdv57', 'b0b15bcw', 'b09706s2', 'b0b0b6k2', 'b08vfkzp', 'b09xy93q', 'b0b2lk93', 'b00qzskp', 'b08llqhj', 'b03b7p77', 'b09kdm7j', 'b08x0g7p', 'b04x6xm1', 'b097l4vn', 'b09h2q8x', 'b0b4zx3t', 'b03nv05z', 'b092z069', 'b092qjfg', 'b09f8j5f', 'b095byv1', 'b09f3l1r', 'b01hj76t', 'p06080gh', 'b090rb6d', 'b08qhxvm', 'b09ysjgz', 'b0962b77', 'b0957n0m', 'b09pywh0', 'b09hmvfl', 'b09ypxct', 'b06jltst', 'b09h0hl0', 'b09br24w', 'b09ypx3n', 'b09lsp2x', 'b08w93wl', 'b0214pvz', 'b09g43n5', 'b03xkpv3', 'b09s787v', 'b08llksd', 'b07ptgh5', 'b01p53h9', 'b04wz81v', 'b01n8jdn', 'b094f4gs', 'b08nwtkp', 'b03f0lxl', 'b04dr3q7', 'b01pmc26', 'b05y97qz', 'b04lhh4s', 'b00k87g8', 'b04y6xvk', 'b007llps', 'b07wzzz6', 'b07wr1v2', 'b04ww1pg', 'b08t08fv', 'b008cxyb', 'b078j08t', 'b08sw64s', 'b054yj22', 'b0b56z44', 'b01rrzth', 'b037kydx', 'b03yrln9', 'b03vq1ss', 'b019m1d6', 'b03qgsw8', 'b01npfrr', 'b0485xw9', 'b03p8sls', 'b03xl5df', 'b08rmklb', 'b08vkm52', 'b09t88q3', 'b09qrj3g', 'b09fc4qj', 'b0906s5g', 'b09lsns0', 'b0949h54', 'b092sx27', 'b09lym4z', 'b095mkc4', 'b09m4x0y', 'b08f0kqs', 'b096kytj', 'b092qjvb', 'b067gcj6', 'b09xy8bp', 'b09g5f6z', 'b090rrl2', 'b09bqyp7', 'b07w1dpx', 'b09kg57n', 'b08s46tk', 'b09pyvmw', 'b09l90ml', 'b08svvgx', 'b09svkpp', 'b00ls8ll', 'b0998kll', 'b095c2vq', 'b09jhv6q', 'b09pyrsz', 'b0864482', 'b09sjsry', 'b0911wqt', 'b09m2bnr', 'b09gnqp2', 'b08w9688', 'b07hjcz5', 'b08zbxmh', 'b096dh32', 'b0962xqf', 'b09v3gwm', 'b0911ymz', 'b0953zyy', 'b07ktd7x', 'b091fpx4', 'b09qwb65', 'b07yvtm3', 'b09f8lcm', 'b09t86q9', 'b08zbf23', 'b07pkg6b', 'b06rll2w', 'b00srz5b', 'b09lyrm6', 'b095705c', 'b0b02vhg', 'b09ysnw5', 'b09g3px0', 'b08x0gdj', 'b097l8xx', 'b08w58z1', 'b0916lcd', 'b09lwjfl', 'b09t8bt7', 'b09jhw5q', 'b08xzm2m', 'b01rv1wv', 'b09m3d5b', 'b09br47p', 'b09cft8p', 'b08z9kgm', 'b08rcm5v', 'b08p31n3', 'b03trmq3', 'b08t185q', 'b0953n80', 'b08mkhd5', 'b09fb6v2', 'b09vl40v', 'b09kbmrh', 'b09jn0ly', 'b053m865', 'b06qdbr9', 'b0b2jqmx', 'b00t6yj9', 'b060fks7', 'b062x6m6', 'b09s0h68', 'b09mt7fv', 'b072nhsd', 'b08x1qy6', 'b08w2dyl', 'b03jywcs', 'b09m7l0g', 'b00f84mt', 'b0b3v54q', 'b01p0rl9', 'b092sfrz', 'b04vd0nr', 'b08yn8ff', 'b083vq05', 'b00vys24', 'b061r42d', 'b04pbwqj', 'b00w7k86', 'b08t15mf', 'b06bqtkd', 'b06br4f4', 'b09v3gwm', 'b00hpm38', 'b06kx6kg', 'b09163st', 'b06bpn9q', 'b098phk8', 'b0b2nxys', 'b0953vdz', 'b08wzbz5', 'b04g6y0r', 'b09yvkt0', 'b01q9tbk', 'b036wvkp', 'b07gm32h', 'b08s3sqz', 'b043x70b', 'b09gr2p5', 'b06t63d2', 'b04cgq4g', 'b08xx830', 'b03ggp49', 'b09xctlb', 'b04v98w8', 'b0729xtf', 'b09t86lr', 'b084fsfq', 'b039vjb1', 'b0953zj8', 'b01qzcvv', 'b09blc8w', 'b09q1bvr', 'b00cwgtc', 'b092st7l', 'b04gyp85', 'b092f45d', 'b01qllhl', 'b087b9qx', 'b05v4czn', 'b08g0170', 'b06b83wg', 'b08x94mx', 'b05xpyzw', 'b09xqj52', 'b01bw531', 'b09vl3qp', 'b04yc2dc', 'b0b0yc51', 'b097ml3n', 'b01cp16j', 'b09bwf8z', 'b09dj2wf', 'b09tbxwv', 'b039p5ws', 'b01mk989', 'b088nzc1', 'b0721287', 'b08w53jr', 'b0436r3b', 'b043j8x2', 'b0403v0g', 'b098sf3q', 'b03ybqtv', 'b09vm093', 'b074wwd0', 'b04knt4h', 'b08xrqns', 'b03y0hqc', 'b03zqn53', 'b03v351j', 'b09jhp7p', 'b08xrk9t', 'b09m3cg6', 'b08bgztl', 'b06bqctk', 'b009z2ds', 'b04kpx00', 'b084fr6p', 'b07nsf2x', 'b011g97z', 'b09k9jhx', 'b049fgbc', 'b02xb2v8', 'b04c9s85', 'b097lb2s', 'b09t89cb', 'b088tzkv', 'b08t3bwh', 'b0b01lcy', 'b08zqr1q', 'w27vpwq4', 'p058w7dp', 'b007d6gv', 'b036tc67', 'b013sqmg', 'b0949879', 'b09tc6rp', 'b00crrh8', 'b09bbg27', 'b01s2kcr', 'b07b2xxw', 'b00fjc2k', 'b00ft3yx', 'b00f6gsd', 'b063m8h9', 'b00c1xwl', 'b0990q7w', 'b017gq53', 'b00wls5y', 'b00bz65t', 'b00dn9rl', 'b00b98d4', 'b077rlyw', 'b068b5jj', 'b00nnrh6', 'b041xzzn', 'b01p7bqh', 'b00vvwv9', 'b01q0hvz', 'b00fgszb', 'b01jrshp', 'b00cftjq', 'b00cwpvn', 'b00h4r36', 'b00dpyg1', 'b009sm39', 'b00g4839', 'b00b5r2q', 'b010ns42', 'b00cjzpf', 'b00fsxp4', 'b00lcmc0', 'b00dzlrm', 'b07g8nnl', 'b00dm1pz', 'b00kkg1m', 'b068sfwx', 'b098ssf8', 'b00xgp3j', 'b07j8jnq', 'b00b5lq5', 'b00hkbrw', 'b048z181', 'b00d4xlc', 'b00fyjyz', 'b009sm1v', 'b09jc47h', 'b00czgtq', 'b00m3y0q', 'b00y9y8y', 'b02x5kph', 'b08yntkz', 'b00lb6f2', 'b09hx1pg', 'b00x18hm', 'b08x1r3t', 'b0072vcc', 'b00pfmfr', 'b0153s4w', 'b06rv3dt', 'b08yr378', 'b00crcw3', 'b00bg37x', 'b00clvm5', 'b00f850k', 'b08z8wyy', 'b09tx1f2', 'b00jkhh3', 'b09g4bdr', 'b09xsqbk', 'b00dxjz5', 'b01jhxdt', 'b00rd8z5', 'b053lhjf', 'b092g6x7', 'b09ms3kb', 'b0948qlh', 'b01l02f9', 'b0126c1d', 'b0b04vqg', 'b01nm1s0', 'b00fr23f', 'b00fgs8s', 'b00m6bbs', 'b009twjj', 'b007d9xl', 'b00gd4tg', 'b08n274n', 'b09qr7q7', 'b00p6rc4', 'b050gvz4', 'b04t74cm', 'b0949j8y', 'b05yy7ts', 'b00dpz3s', 'b00lmcx6', 'b012rxql', 'b012fc02', 'b00bzrjc', 'b00crn22', 'b007d637', 'b00sg0yk', 'b00f6m22', 'b00w8hsk', 'b009v2dy', 'b07dx2t3', 'b00ffnsz', 'b00xn6t8', 'b04411q0', 'b00ss2xd', 'b00v9ltp', 'b00fq43l', 'b00jg7wt', 'b03np5nk', 'b006qxtr', 'b00ngz51', 'b039tnfc', 'b05syhzr', 'b00cg0md', 'b00c8r8k', 'b00bg34c', 'b01s70x4', 'b00cjnm4', 'b011379w', 'b00np1nz', 'b00tq38j', 'b09hmt04', 'b00cnw4v', 'b0072v5l', 'b0129sbz', 'b0071prw', 'b00c4n68', 'b00ffl7c', 'b09hqmc1', 'b00tdmgf', 'b00wh4n3', 'b09m4zhp', 'b00czhbq', 'b01b20s1', 'b00h33ht', 'b00f1p74', 'b00lwdz7', 'b00sp45b', 'b0080fnj', 'b03b3cd0', 'b00fq3cf', 'b09xtwjz', 'b00h4wb5', 'b00fqhf2', 'b09mrq21', 'b00qtmqq', 'b06hcbvs', 'b006vn7f')
GROUP BY programme_title, genres_list_a_names, genres_list_b_names, genres_list_c_names, genres_list_d_names, pips_genre_level_1_names, pips_genre_level_2_names
limit 1000;

--realised that formats are in the metadata table so adding those in--
ALTER TABLE central_insights_sandbox.sho_sticking_point_radio_od_enriched
    ADD COLUMN format_names VARCHAR(4000);
UPDATE central_insights_sandbox.sho_sticking_point_radio_od_enriched
    SET format_names = central_insights.programme_metadata.format_names
    FROM central_insights.programme_metadata
WHERE central_insights_sandbox.sho_sticking_point_radio_od_enriched.series_id = central_insights.programme_metadata.series_id
;

ALTER TABLE central_insights_sandbox.sho_sticking_point_radio_od_enriched
    ADD COLUMN tx_date date;
UPDATE central_insights_sandbox.sho_sticking_point_radio_od_enriched
    SET tx_date = central_insights.programme_metadata.tx_date
FROM central_insights.programme_metadata
WHERE central_insights_sandbox.sho_sticking_point_radio_od_enriched.version_id = central_insights.programme_metadata.version_id
;

--create table with avg days between each episode to get release schedule
CREATE TEMP TABLE radio_schedule
(programme_title VARCHAR(400),
tx_date         DATE)
SORTKEY(programme_title, tx_date)
;
INSERT INTO radio_schedule
SELECT programme_title, tx_date
FROM central_insights_sandbox.sho_sticking_point_radio_od_enriched
GROUP BY programme_title, tx_date;

CREATE TABLE central_insights_sandbox.sho_sticking_point_radio_schedule
(
  programme_title    VARCHAR(400),
  tx_date            DATE,
  days_since_last_tx INT
)
;
INSERT INTO central_insights_sandbox.sho_sticking_point_radio_schedule
SELECT
    programme_title,
    tx_date,
    CAST(datediff(day,(LAG (tx_date, 1)
          OVER(PARTITION BY programme_title ORDER BY tx_date ASC)),
          tx_date)
         AS INT)
FROM radio_schedule
GROUP BY programme_title, tx_date
;
SELECT programme_title, median(days_since_last_tx)
FROM central_insights_sandbox.sho_sticking_point_radio_schedule
GROUP BY programme_title;

