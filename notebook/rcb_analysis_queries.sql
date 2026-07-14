-- ============================================
-- RCB IPL ANALYSIS — COMPLETE SQL QUERIES
-- ============================================
-- Author: Bharath Poothireddy
-- Dataset: IPL 2008-2024
-- Tables: matches (1,095 rows), deliveries (260,920 rows)
-- Database: SQLite
-- ============================================
-- This file contains 10 key queries analyzing
-- Royal Challengers Bengaluru's performance
-- across all 17 IPL seasons.
-- ============================================


-- ============================================
-- 1. OVERALL RECORD
-- Calculate RCB's all-time win/loss record
-- ============================================

-- SELECT 
        season,
        COUNT(*) as matches_played,
        COUNT(CASE WHEN winner LIKE '%Royal Challengers%' THEN 1 END) as matches_won,
        ROUND(COUNT(CASE WHEN winner LIKE '%Royal Challengers%' THEN 1 END) * 100.0 / COUNT(*), 1) as win_pct
    FROM matches 
    WHERE team1 = 'Royal Challengers Bengaluru' or team2 = 'Royal Challengers Bengaluru'
    GROUP BY season
    ORDER BY season


-- ============================================
-- 2. SEASON-BY-SEASON PERFORMANCE
-- Win percentage for RCB in each IPL season
-- ============================================

-- SELECT 
        season,
        COUNT(*) as matches_played,
        COUNT(CASE WHEN winner LIKE '%Royal Challengers%' THEN 1 END) as matches_won,
        ROUND(COUNT(CASE WHEN winner LIKE '%Royal Challengers%' THEN 1 END) * 100.0 / COUNT(*), 1) as win_pct
    FROM matches 
    WHERE team1 = 'Royal Challengers Bengaluru' or team2 = 'Royal Challengers Bengaluru'
    GROUP BY season
    ORDER BY season


-- ============================================
-- 3. TOSS IMPACT ANALYSIS
-- Does winning the toss improve RCB's win%?
-- ============================================

-- SELECT 
    CASE 
        WHEN toss_winner like 'Royal Challengers%' THEN 'Won Toss'
        ELSE 'Lost Toss'
    END AS toss_result,
    COUNT(*) AS total_matches,
    COUNT(CASE WHEN winner like 'Royal Challengers%' THEN 1 END) AS wins,
    ROUND(COUNT(CASE WHEN winner like 'Royal Challengers%' THEN 1 END) * 100.0 / COUNT(*), 1) AS win_pct
    FROM matches
    WHERE team1 like 'Royal Challengers%'
       OR team2 like 'Royal Challengers%'
    GROUP BY toss_result


-- ============================================
-- 4. ABOVE-AVERAGE SCORE
-- MATCHES WHERE RCB SCORED ABOVE THEIR AVERAGE
-- ============================================

-- SELECT 
    d.match_id,
    m.season,
    SUM(d.total_runs) AS match_runs
    FROM deliveries d
    JOIN matches m ON d.match_id = m.id
    WHERE d.batting_team LIKE 'Royal Challengers%'
    GROUP BY d.match_id
    HAVING SUM(d.total_runs) > (
        SELECT AVG(match_runs)
        FROM (
            SELECT 
                match_id,
                SUM(total_runs) AS match_runs
            FROM deliveries
            WHERE batting_team LIKE 'Royal Challengers%'
            GROUP BY match_id
        )
    )
    ORDER BY match_runs DESC


-- ============================================
-- 5. TOP 5 BATSMEN — TOTAL RUNS
-- Highest run-scorers for RCB across all seasons
-- ============================================

-- SELECT 
    batter,
    SUM(batsman_runs) AS total_runs
    FROM deliveries
    WHERE batting_team LIKE 'Royal Challengers%'
    GROUP BY batter
    ORDER BY total_runs DESC
    LIMIT 5;


-- ============================================
-- 6. TOP 5 BOWLERS — TOTAL WICKETS
-- Leading wicket-takers for RCB
-- ============================================

--  SELECT 
    bowler,
    SUM(is_wicket) AS total_wickets
    FROM deliveries
    WHERE bowling_team LIKE 'Royal Challengers%'
        AND is_wicket = 1
        AND wicket_type NOT IN ('run out', 'retired hurt')  
    GROUP BY bowler
    ORDER BY total_wickets DESC
    LIMIT 5;


-- ============================================
-- 7. RUNS IN WINS vs LOSSES
-- Batting performance split by match outcome
-- ============================================

-- SELECT 
    batter, 
    SUM(batsman_runs) as total_runs,
    SUM(CASE WHEN winner LIKE 'ROYAL CHALLENGERS%' THEN batsman_runs ELSE 0 END) as runs_in_wins,
    SUM(CASE WHEN winner NOT LIKE 'ROYAL CHALLENGERS%' THEN batsman_runs ELSE 0 END) as runs_in_loss
    FROM matches
    JOIN deliveries ON matches.id = deliveries.match_id
    WHERE batting_team LIKE 'Royal Challengers%'
    GROUP BY batter
    ORDER BY total_runs DESC
    LIMIT 10


-- ============================================
-- 8. VENUES WITH >50% WIN RATE
-- RCB's best-performing home/away venues
-- ============================================

--  WITH venue_stats AS (
    SELECT 
        standardized_venue AS venue,
        COUNT(*) AS total_matches,
        COUNT(CASE WHEN winner LIKE 'Royal Challengers%' THEN 1 END) AS wins,
        COUNT(CASE WHEN winner NOT LIKE 'Royal Challengers%' AND winner IS NOT NULL THEN 1 END) AS losses,
        ROUND(
            COUNT(CASE WHEN winner LIKE 'Royal Challengers%' THEN 1 END) * 100.0 / COUNT(*), 
            1
        ) AS win_pct
    FROM (
        SELECT 
            CASE 
                WHEN venue LIKE '%Chinnaswamy%' OR (venue LIKE '%Bengaluru%' AND venue LIKE '%Stadium%') 
                    THEN 'M. Chinnaswamy Stadium, Bengaluru'
                WHEN venue LIKE '%Punjab Cricket Association%' OR venue LIKE '%IS Bindra%' 
                    THEN 'Punjab Cricket Association IS Bindra Stadium, Mohali'
                WHEN venue LIKE '%Dubai%' THEN 'Dubai International Cricket Stadium'
                WHEN venue LIKE '%Wankhede%' THEN 'Wankhede Stadium, Mumbai'
                WHEN venue LIKE '%Feroz Shah%' OR venue LIKE '%Kotla%' 
                    THEN 'Feroz Shah Kotla, Delhi'
                WHEN venue LIKE '%Chidambaram%' OR venue LIKE '%Chepauk%' 
                    THEN 'MA Chidambaram Stadium, Chepauk, Chennai'
                ELSE TRIM(venue)
            END AS standardized_venue,
            winner
        FROM matches
        WHERE team1 LIKE 'Royal Challengers%'
           OR team2 LIKE 'Royal Challengers%'
    ) AS cleaned_venues
    GROUP BY standardized_venue
    )
    SELECT *
    FROM venue_stats
    WHERE total_matches >= 3 
      AND win_pct > 50.0
    ORDER BY win_pct DESC, total_matches DESC;


-- ============================================
-- 9. ABOVE-AVERAGE POTM PERFORMERS
-- Players with more POTM awards than the RCB average
-- ============================================

-- SELECT 
    player_of_match,
    COUNT(*) AS potm_count
    FROM matches
    WHERE winner LIKE 'Royal Challengers%'
    GROUP BY player_of_match
    HAVING COUNT(*) > (
        SELECT AVG(potm_count)
        FROM (
            SELECT COUNT(*) AS potm_count
            FROM matches
            WHERE winner LIKE 'Royal Challengers%'
            GROUP BY player_of_match
        )
    )
    ORDER BY potm_count DESC


-- ============================================
-- 10. TOP 5 INDIVIDUAL BATTING PERFORMANCES
-- Highest runs scored by a single batsman in a match
-- ============================================

-- SELECT 
    match_id,
    batter,
    runs_scored
    FROM (
        SELECT 
            match_id,
            batter,
            SUM(batsman_runs) AS runs_scored
        FROM deliveries
        WHERE batting_team LIKE 'Royal Challengers%'
        GROUP BY match_id, batter
    ) AS innings_stats  
    ORDER BY runs_scored DESC
    LIMIT 5;


-- ============================================
-- END OF FILE
-- ============================================