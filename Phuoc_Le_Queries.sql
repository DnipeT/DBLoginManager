-------------- Scenarios
-- 1. Login- A player must be able to login to their account via riot account login. A player can only have 1 account per email associated with their riot account.
SELECT * FROM phuoc_le_db.riotaccount;

-- 2. Create riot account- A player must be able to create a new riot account with an email that is currently not being used by another player.
INSERT INTO phuoc_le_db.riotaccount (UserName, Email, PlayerId, AccountPassword, Country, DateofBirth)
VALUES ('example_user', 'example@email.com', 10, 'password123', 'United States', '01-01-2000');

-- 3. Game stats- A player must be able to see their stats after they have completed a game
  SELECT * FROM phuoc_le_db.aftergamestats;
 
 -- 4. Select a game type- A player has the choice of deciding which game type they want to gametypeplay. Players cannot be queued in more than one game type.
 SELECT * FROM phuoc_le_db.gametype;

-- 5. Stats - A player is able to get stats for each unique entity, their agent played, maps played and weapons used
SELECT ps.PlayerId, ps.HeadShotPercent, ps.WinLossPercent, ags.AgentName, ags.TopMap, abss.AgentName, abss.AbilityName, abss.EnemiesAffected, abss.AlliesAffected
FROM playerstats ps
JOIN agentstats ags ON ps.PlayerId = ags.PlayerId
JOIN abilitystats abss ON ps.PlayerId = abss.PlayerId;

-- 6. Settings - A player can be able to access their settings at any point as long as they are logged in and be able to make changes to it.
SELECT * FROM phuoc_le_db.settings;

-- 7. Shop - A player can access the shop to purchase armor, abilities and weapons at the start of every round as long as they have enough money. Players cannot have more than 1 primary and secondary weapon
SELECT * FROM phuoc_le_db.weaponstats;
       
-------------- Analytical Queries
-- 1. Find the best agent based on win % for a map
SELECT ms.MapName, agentstats.AgentName, agentstats.WinPercentage
FROM mapstats ms
JOIN agentstats ON ms.PlayerId = agentstats.PlayerId AND ms.MapName = agentstats.TopMap
WHERE ms.MapName = 'Bind'
ORDER BY agentstats.WinPercentage DESC
LIMIT 1;

-- 2. Find other players close to the same rank as you to play with.
SELECT *
FROM ranks
WHERE `RegionRankPlacement` >=  5000
  AND `RegionRankPlacement` <= 15000
  AND PlayerId <> '1';
  
-- 3. Find the agent who has the highest KDA(kill/death/assist).
SELECT AgentName, KDA
FROM agentstats
ORDER BY KDA DESC
LIMIT 1;

-- 4. Find the map that is chosen the most
SELECT MapName, COUNT(*) AS ChosenCount
FROM phuoc_le_db.maps
GROUP BY MapName
ORDER BY ChosenCount DESC
LIMIT 1;

-- 5. Find the gun that is the most bought and gives the most ADR (average damage per round)
SELECT w.WeaponName, w.Cost, ws.AverageDamagePerRound
FROM weapon w
JOIN weaponstats ws ON w.PlayerId = ws.PlayerId AND w.WeaponName = ws.WeaponName
GROUP BY w.WeaponName, w.Cost, ws.AverageDamagePerRound
ORDER BY COUNT(*) DESC, ws.AverageDamagePerRound DESC
LIMIT 1;