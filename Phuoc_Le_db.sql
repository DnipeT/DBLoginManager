CREATE DATABASE phuoc_le_db;
CREATE TABLE `phuoc_le_db`.`player` (
  `PlayerId` INT NOT NULL,
  `PlayerName` VARCHAR(45) NULL,
  `PlayerTag` INT NOT NULL,
  `Level` INT NULL DEFAULT 0,
  `Rank` VARCHAR(45) NULL,
  PRIMARY KEY (`PlayerId`));
  
INSERT INTO `phuoc_le_db`.`player` (`PlayerId`, `PlayerName`,`PlayerTag`, `Level`, `Rank`) 
VALUES (1, 'Ronaldo',123456, 10, 'Diamond'),
       (2, 'Messi', 789012, 5, 'Gold'),
       (3, 'Kaka', 345678, 3, 'Silver');
       
CREATE TABLE `phuoc_le_db`.`weapon` (
  `PlayerId` INT NOT NULL,
  `WeaponName` VARCHAR(45) NOT NULL,
  `Cost` INT NULL,
  `WeaponType` VARCHAR(45) NULL,
  PRIMARY KEY (`PlayerId`, `WeaponName`));
  
INSERT INTO `phuoc_le_db`.`weapon` (`PlayerId`, `WeaponName`, `Cost`, `WeaponType`)
VALUES (1, 'Vandal', 2900, 'Rifle'),
       (2, 'Operator', 4500, 'Sniper'),
       (3, 'Sheriff', 800, 'Pistol');
       

-- didnt create FK for this 
CREATE TABLE `phuoc_le_db`.`weaponstats` (
  `PlayerId` INT NOT NULL,
  `WeaponName` VARCHAR(45) NOT NULL,
  `HeadshotPercentage` INT NULL,
  `Kills` INT NULL,
  `AverageDamagePerRound` INT NULL,
  PRIMARY KEY (`PlayerId`, `WeaponName`));
  
INSERT INTO `phuoc_le_db`.`weaponstats` (`PlayerId`, `WeaponName`, `HeadshotPercentage`, `Kills`, `AverageDamagePerRound`)
VALUES (1, 'Vandal', 70, 50, 120),
       (2, 'Operator', 65, 45, 115),
       (3, 'Sheriff', 80, 35, 150);

       
CREATE TABLE `phuoc_le_db`.`maps` (
  `MapName` VARCHAR(45) NOT NULL,
  `PlayerId` VARCHAR(45) NOT NULL,
  `NumberofSites` INT NULL,
  PRIMARY KEY (`MapName`, `PlayerId`));
  
INSERT INTO `phuoc_le_db`.`maps` (`MapName`, `PlayerId`, `NumberofSites`)
VALUES ('Bind', 1, 2),
       ('Split', 2, 2),
       ('Haven', 3, 3);

CREATE TABLE `phuoc_le_db`.`mapstats` (
  `PlayerId` INT NOT NULL,
  `MapName` VARCHAR(45) NULL,
  `TopAgent` VARCHAR(45) NULL,
  `Wins` INT NULL,
  `Losses` INT NULL,
  `WinPercentage` INT NULL,
  CONSTRAINT `FK_mapstats_map`
    FOREIGN KEY (`MapName`)
    REFERENCES `maps` (`MapName`),
  PRIMARY KEY (`PlayerId`)
);
INSERT INTO `phuoc_le_db`.`mapstats` (`PlayerId`, `MapName`, `TopAgent`, `Wins`, `Losses`, `WinPercentage`)
VALUES (1, 'Bind', 'Jett', 10, 5, 66),
       (2, 'Split', 'Phoenix', 8, 3, 73),
       (3, 'Haven', 'Sage', 12, 2, 86);
       
CREATE TABLE `phuoc_le_db`.`agent` (
  `AgentName` VARCHAR(45) NOT NULL,
  `PlayerId` INT NOT NULL,
  `AgentType` VARCHAR(45) NULL,
  PRIMARY KEY (`AgentName`, `PlayerId`));
  
INSERT INTO `phuoc_le_db`.`agent` (`AgentName`, `PlayerId`, `AgentType`)
VALUES ('Jett', 1, 'Duelist'),
       ('Phoenix', 2, 'Duelist'),
       ('Sage', 3, 'Sentinel');

CREATE TABLE `phuoc_le_db`.`agentstats` (
  `PlayerId` INT NOT NULL,
  `AgentName` VARCHAR(45) NULL,
  `TopMap`  VARCHAR(45) NULL,
  `HeadshotPercentage` INT NULL,
  `KDA` DECIMAL(4,2) NULL,
  `Wins` INT NULL,
  `Losses` INT NULL,
  `WinPercentage` INT NULL,
  `ChoosePercentage` INT NULL,
  `HoursPlayed` INT NULL,
  	CONSTRAINT `FK_agentstats_agent`
      FOREIGN KEY (`AgentName`)
      REFERENCES `agent` (`AgentName`),
  PRIMARY KEY (`PlayerId`));
INSERT INTO `phuoc_le_db`.`agentstats` (`PlayerId`, `AgentName`, `TopMap`, `HeadshotPercentage`, `KDA`, `Wins`, `Losses`, `WinPercentage`, `ChoosePercentage`, `HoursPlayed`)
VALUES (1, 'Jett', 'Bind', 70, 2.5, 20, 10, 66, 30, 50),
       (2, 'Phoenix', 'Haven', 65, 3.2, 18, 8, 69, 25, 45),
       (3, 'Sage', 'Split', 75, 2.8, 25, 5, 83, 35, 60);
       
CREATE TABLE `phuoc_le_db`.`abilities` (
  `PlayerId` INT NOT NULL,
  `AgentName` VARCHAR(45) NOT NULL,
  `AbilityName` VARCHAR(45) NOT NULL,
  `KeyBind` VARCHAR(45) NULL,
  `Cost` INT NULL,
  PRIMARY KEY ( `AgentName`, `AbilityName`,`PlayerId`));
  
  
INSERT INTO `phuoc_le_db`.`abilities` (`PlayerId`, `AgentName`, `AbilityName`, `KeyBind`, `Cost`)
VALUES
  (1, 'Jett', 'Cloudburst', 'Q', 100),
  (1, 'Jett', 'Updraft', 'E', 200),
  (1, 'Jett', 'Blade Storm', 'X', 6),
  (2, 'Phoenix', 'Hot Hands', 'Q', 200),
  (2, 'Phoenix', 'Blaze', 'E', 250),
  (2, 'Phoenix', 'Run It Back', 'X', 7),
  (3, 'Sage', 'Slow Orb', 'Q', 100),
  (3, 'Sage', 'Barrier Orb', 'E', 400),
  (3, 'Sage', 'Resurrection', 'X', 7);
  
CREATE TABLE `phuoc_le_db`.`abilitystats` (
  `PlayerId` INT NOT NULL,
  `AgentName` VARCHAR(45) NOT NULL,
  `AbilityName` VARCHAR(45) NOT NULL,
  `EnemiesAffected` INT,
  `AlliesAffected` INT,
  PRIMARY KEY ( `AgentName`, `AbilityName`,`PlayerId`),
  CONSTRAINT `FK_abilitystats_abilities`
    FOREIGN KEY (`AgentName`, `AbilityName`)
    REFERENCES `abilities` ( `AgentName`, `AbilityName`)
);
-- Inserting values into the `abilitystats` table referencing the `abilities` table
INSERT INTO `phuoc_le_db`.`abilitystats` (`PlayerId`, `AgentName`, `AbilityName`, `EnemiesAffected`, `AlliesAffected`)
VALUES
  (1, 'Jett', 'Cloudburst', 0, 2),
  (1, 'Jett', 'Updraft', 1, 3),
  (1, 'Jett', 'Blade Storm', 2, 1),
  (2, 'Phoenix', 'Hot Hands', 1, 2),
  (2, 'Phoenix', 'Blaze', 0, 3),
  (2, 'Phoenix', 'Run It Back', 3, 1),
  (3, 'Sage', 'Slow Orb', 2, 2),
  (3, 'Sage', 'Barrier Orb', 1, 3),
  (3, 'Sage', 'Resurrection', 0, 2);
  
CREATE TABLE `phuoc_le_db`.`gametype` (
  `PlayerId` INT NOT NULL,
  `GameTypeName` VARCHAR(45) NOT NULL,
  `NumberofRound` INT NULL,
  PRIMARY KEY (`PlayerId`, `GameTypeName`));
  
INSERT INTO `phuoc_le_db`.`gametype` (`PlayerId`, `GameTypeName`, `NumberofRound`)
VALUES
  (1, 'Deathmatch', 10),
  (1, 'Spike Rush', 5),
  (2, 'Unrated', 13),
  (2, 'Ranked', 25),
  (3, 'Competitive', 20),
  (3, 'Custom', 8);
  
CREATE TABLE `phuoc_le_db`.`aftergamestats` (
  `PlayerId` INT NOT NULL,
  `GameTypeName` VARCHAR(45) NOT NULL,
  `Kills` INT NULL,
  `Deaths` INT NULL,
  `Assists` INT NULL,
  `AverageCombatScore` INT NULL,
  PRIMARY KEY (`PlayerId`, `GameTypeName`));
  
INSERT INTO `phuoc_le_db`.`aftergamestats` (`PlayerId`, `GameTypeName`, `Kills`, `Deaths`, `Assists`, `AverageCombatScore`)
VALUES
  -- Player 1's after game stats
  (1, 'Deathmatch', 20, 5, 10, 250),
  (1, 'Spike Rush', 10, 3, 5, 180),
  -- Player 2's after game stats
  (2, 'Unrated', 15, 8, 12, 210),
  (2, 'Ranked', 12, 4, 8, 190),
  -- Player 3's after game stats
  (3, 'Competitive', 18, 6, 15, 230),
  (3, 'Custom', 8, 2, 4, 170);
  
  ---------------------------
  CREATE TABLE phuoc_le_db.playerstats (
  PlayerId INT NOT NULL,
  HeadShotPercent INT NULL,
  WinLossPercent INT NULL,
  CONSTRAINT FK_playerstats_player
    FOREIGN KEY (PlayerId)
    REFERENCES player (PlayerId),
  PRIMARY KEY (PlayerId)
);

INSERT INTO phuoc_le_db.playerstats (PlayerId, HeadShotPercent, WinLossPercent) 
VALUES (1, 35, 80),
       (2, 25, 70),
       (3, 18, 70);

CREATE TABLE phuoc_le_db.playerkda (
	PlayerId INT NOT NULL,
	Kills INT NOT NULL,
	Deaths INT NOT NULL,
    Assists INT NOT NULL,
	CONSTRAINT FK_playerkda_player
		FOREIGN KEY (PlayerId)
		REFERENCES player (PlayerId),
	PRIMARY KEY (PlayerId)
);
INSERT INTO phuoc_le_db.playerkda (PlayerId, Kills, Deaths, Assists) 
VALUES (1, 2000, 1040, 590),
       (2, 1550, 1000, 250),
       (3, 1250, 1300, 750);

CREATE TABLE phuoc_le_db.ranks (
	RegionRankPlacement INT NULL,
    PlayerId INT NOT NULL,
    RankName VARCHAR(45) NOT NULL,
    RankDevision INT NOT NULL,
    RankRating INT NULL,
    CONSTRAINT FK_ranks_player
		FOREIGN KEY (PlayerId)
		REFERENCES player (PlayerId),
	PRIMARY KEY (PlayerId)
);
INSERT INTO phuoc_le_db.ranks (RegionRankPlacement, PlayerId, RankName, RankDevision, RankRating) 
VALUES (5250, 1, 'Diamond', 1, 78),
       (12520, 2, 'Gold', 2, 24),
       (25550, 3, 'Silver', 3, 93);

CREATE TABLE phuoc_le_db.riotaccount (
	UserName VARCHAR(45) NOT NULL,
    Email VARCHAR(45) NOT NULL,
    PlayerId INT NOT NULL,
    AccountPassword VARCHAR(45) NOT NULL,
    Country VARCHAR(45) NULL,
    DateofBirth VARCHAR(45) NULL,
    CONSTRAINT FK_riotaccount_player
		FOREIGN KEY (PlayerId)
		REFERENCES player (PlayerId),
	PRIMARY KEY (PlayerId)
);
INSERT INTO phuoc_le_db.riotaccount (UserName, Email, PlayerId, AccountPassword, Country, DateofBirth) 
VALUES ('Ronalddonald', 'RD@email.com', 1, 'ronnyPassword', 'UK', NULL),
       ('Messi1', 'Messi@email.com', 2, 'MessiPassword', 'UK', '12/12/1980'),
       ('kakakaka', 'KKaa@email.com', 3, 'kakaka', 'US', NULL);

CREATE TABLE phuoc_le_db.settings (
	PlayerId INT NOT NULL,
    Graphics VARCHAR(45) NOT NULL DEFAULT 'Medium',
    MaxFPS INT NOT NULL,
	CONSTRAINT FK_settings_player
		FOREIGN KEY (PlayerId)
		REFERENCES player (PlayerId),
	PRIMARY KEY (PlayerId)
);
INSERT INTO phuoc_le_db.settings (PlayerId, Graphics, MaxFPS) 
VALUES (1, 'High', 120),
       (2, DEFAULT, 60),
       (3, DEFAULT, 60);

CREATE TABLE phuoc_le_db.audio (
	PlayerId INT NOT NULL,
    OverallVolume INT NOT NULL DEFAULT 100,
    SoundEffectVolume INT NOT NULL DEFAULT 100,
    AgentVolume INT NOT NULL DEFAULT 100,
    OtherPlayerVolume INT NOT NULL DEFAULT 100,
    CONSTRAINT FK_audios_player
		FOREIGN KEY (PlayerId)
		REFERENCES player (PlayerId),
	PRIMARY KEY (PlayerId)
);
INSERT INTO phuoc_le_db.audio (PlayerId, OverallVolume, SoundEffectVolume, AgentVolume, OtherPlayerVolume) 
VALUES (1, 70, 70, DEFAULT, DEFAULT),
       (2, DEFAULT, 70, 50, 95),
       (3, 70, 70, 50, DEFAULT);

CREATE TABLE phuoc_le_db.controls (
	PlayerId INT NOT NULL,
    AimSensitivity DECIMAL(6,4) NOT NULL,
    ScopedSensitivity DECIMAL(3,2) NOT NULL,
    ADSSensitivityMultiplier INT NOT NULL,
    MinimapZoom DECIMAL(2,1) NOT NULL,
    MinimapSize DECIMAL(3,2) NOT NULL,
	CONSTRAINT FK_controls_player
		FOREIGN KEY (PlayerId)
		REFERENCES player (PlayerId),
	PRIMARY KEY (PlayerId)
); 
INSERT INTO phuoc_le_db.controls (PlayerId, AimSensitivity, ScopedSensitivity, ADSSensitivityMultiplier, MinimapZoom, MinimapSize) 
VALUES (1, .25, 1.1, 1, 1.2, .87),
       (2, .2, 1, 1, 1.1, .85),
       (3, .405, 1.25, 1, .9, .8);
       
       



