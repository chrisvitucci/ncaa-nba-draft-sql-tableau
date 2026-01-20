CREATE TABLE nba_draft.draft_players (
  pick_tier VARCHAR(20),
  pick INT,
  player_name VARCHAR(100),
  School VARCHAR(100),
  G INT,
  GS INT,
  MP DECIMAL(4,1),
  FG DECIMAL(4,1),
  FGA DECIMAL(4,1),
  fg_pct DECIMAL(5,3),
  threep DECIMAL(4,1),
  threepa DECIMAL(4,1),
  threep_pct DECIMAL(5,3),
  twop DECIMAL(4,1),
  twopa DECIMAL(4,1),
  twop_pct DECIMAL(5,3),
  efg_pct DECIMAL(5,3),
  FT DECIMAL(4,1),
  FTA DECIMAL(4,1),
  ft_pct DECIMAL(5,3),
  ORB DECIMAL(4,1),
  DRB DECIMAL(4,1),
  TRB DECIMAL(4,1),
  AST DECIMAL(4,1),
  STL DECIMAL(4,1),
  BLK DECIMAL(4,1),
  TOV DECIMAL(4,1),
  PF DECIMAL(4,1),
  PTS DECIMAL(4,1),
  years_played INT,
  Class VARCHAR(20),
  years_on_contract INT,
  rookie_salary BIGINT,
  total_rookie_earnings BIGINT,
  career_nba_earnings BIGINT,
  division_level VARCHAR(50)
);
LOAD DATA LOCAL INFILE '/Users/CHRISVITUCCI/Desktop/draft_players.csv'
INTO TABLE nba_draft.draft_players
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
SELECT COUNT(*) FROM nba_draft.draft_players;
SELECT * FROM nba_draft.draft_players LIMIT 5;
SELECT * FROM nba_draft.draft_players LIMIT 5;
SHOW VARIABLES LIKE 'local_infile';
SHOW VARIABLES LIKE 'secure_file_priv';
SELECT
  SUM(player_name IS NULL OR player_name = '') AS missing_names,
  SUM(pick IS NULL) AS missing_picks,
  SUM(PTS IS NULL) AS missing_points
FROM nba_draft.draft_players;
SELECT *
FROM nba_draft.draft_players
WHERE player_name IS NULL OR player_name = '';
DELETE
FROM nba_draft.draft_players
WHERE player_name IS NULL OR player_name = '';
SELECT COUNT(*) 
FROM nba_draft.draft_players
WHERE player_name IS NULL OR player_name = '';
DELETE
FROM nba_draft.draft_players
WHERE player_name IS NULL OR player_name = '';
SET SQL_SAFE_UPDATES = 0;
SELECT COUNT(*)
FROM nba_draft.draft_players
WHERE player_name IS NULL OR player_name = '';
ALTER TABLE nba_draft.draft_players
ADD COLUMN player_id INT AUTO_INCREMENT PRIMARY KEY FIRST;
ALTER TABLE nba_draft.draft_players
CHANGE School school VARCHAR(100),
CHANGE Class class_year VARCHAR(20);
CREATE INDEX idx_player_name ON nba_draft.draft_players(player_name);
CREATE INDEX idx_pick ON nba_draft.draft_players(pick);
CREATE INDEX idx_pick_tier ON nba_draft.draft_players(pick_tier);
CREATE INDEX idx_school ON nba_draft.draft_players(school);
SELECT pick_tier,
       COUNT(*) AS players,
       ROUND(AVG(PTS),1) AS avg_pts,
       ROUND(AVG(rookie_salary),0) AS avg_rookie_salary,
       ROUND(AVG(career_nba_earnings),0) AS avg_career_earnings
FROM nba_draft.draft_players
GROUP BY pick_tier
ORDER BY players DESC;
UPDATE nba_draft.draft_players
SET pick_tier = '1st Round'
WHERE pick_tier IN ('1stRound', 'First Round');

DELETE FROM nba_draft.draft_players
WHERE pick_tier IS NULL OR pick_tier = '';
UPDATE nba_draft.draft_players
SET pick_tier = '1st Round'
WHERE pick_tier IN ('1stRound', 'First Round');

DELETE FROM nba_draft.draft_players
WHERE pick_tier IS NULL OR pick_tier = '';







SELECT
  pick_tier,
  ROUND(AVG(PTS),1) AS pts,
  ROUND(AVG(AST),1) AS ast,
  ROUND(AVG(TRB),1) AS trb,
  ROUND(AVG(threep_pct),3) AS three_pct,
  ROUND(AVG(eFG_pct),3) AS efg
FROM nba_draft.draft_players
GROUP BY pick_tier
ORDER BY
  CASE pick_tier
    WHEN 'Top 3' THEN 1
    WHEN 'Lottery' THEN 2
    WHEN '1st Round' THEN 3
    WHEN '2nd Round' THEN 4
  END;
  
SELECT
pick_tier,
ROUND(AVG(PTS),1) AS avg_pts,
ROUND(AVG(FGA), 1) AS avg_fga,
ROUND(AVG(eFG_pct),3) AS avg_efg,
ROUND(AVG(threep_pct), 3) AS avg_3p,
ROUND(AVG(TOV),1) AS avg_tov
FROM nba_draft.draft_players
GROUP BY pick_tier
ORDER BY 
CASE pick_tier
WHEN 'Top 3' THEN 1
WHEN 'Lottery' THEN 2
WHEN '1st Round' THEN 3
WHEN '2nd Round' Then 4
END;
SELECT player_id, pick_tier
FROM nba_draft.draft_players
WHERE pick_tier = '1stRound';
UPDATE nba_draft.draft_players
SET pick_tier = '1st Round'
WHERE player_id IN (
  SELECT player_id
  FROM (
    SELECT player_id
    FROM nba_draft.draft_players
    WHERE pick_tier = '1stRound'
  ) AS temp
);
SELECT DISTINCT pick_tier
FROM nba_draft.draft_players;

SELECT 
ROUND(AVG(PTS), 1) as avg_pts,
ROUND(AVG(eFG_pct), 2) as avg_efg
FROM nba_draft.draft_players
WHERE pick_tier = '1st Round';

SELECT player_name, pick_tier, pick, rookie_salary, PTS, eFG_pct
FROM nba_draft.draft_players
WHERE pick_tier = '1st Round'
ORDER BY rookie_salary DESC;

-- -- Question: Which college stats best separate 1st vs 2nd round picks?

SELECT *
FROM nba_draft.draft_players;

SELECT 
CASE
  WHEN pick_tier IN ('Top 3', 'Lottery', '1st Round') THEN 'First Round'
  WHEN pick_tier = '2nd Round' THEN 'Second Round'
END AS draft_group,
ROUND(AVG(PTS), 1) AS avg_pts,
  ROUND(AVG(FGA), 1) AS avg_fga,
  ROUND(AVG(eFG_pct), 3) AS avg_efg,
  ROUND(AVG(threep_pct), 3) AS avg_3p,
  ROUND(AVG(TRB), 1) AS avg_trb,
  ROUND(AVG(AST), 1) AS avg_ast,
  ROUND(AVG(TOV), 1) AS avg_tov
  
  FROM nba_draft.draft_players
  
  WHERE pick_tier IN ('Top 3', 'Lottery', '1st Round', '2nd Round')
  GROUP BY draft_group;







 






