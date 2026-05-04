CREATE DATABASE ESportsManagement;
USE ESportsManagement;

CREATE TABLE Teams (
	team_id VARCHAR(10) PRIMARY KEY,
    team_name VARCHAR(200) NOT NULL,
    team_nation VARCHAR(150) NOT NULL UNIQUE,
    team_owner VARCHAR(150),
    team_yearEstablish INT CHECK(team_yearEstablish >= 1900) NOT NUlL
);


CREATE TABLE Players (
	pl_id VARCHAR(10) PRIMARY KEY,
    pl_name VARCHAR(200) NOT NULL,
    pl_nickName VARCHAR(200) DEFAULT 'No nick name',
    pl_position ENUM('mid', 'top', 'bot', 'support', 'jungler'),
    pl_wage DECIMAL(15,2) CHECK(pl_wage>=0),
    pl_idTeam VARCHAR(10),
    
    CONSTRAINT FOREIGN KEY (pl_idTeam) REFERENCES Players(pl_idTeam)
);



CREATE TABLE Matchs (
	match_id VARCHAR(10) PRIMARY KEY,
    match_timeStart DATETIME UNIQUE,
    match_ratio VARCHAR(5)
);


CREATE TABLE Match_Statistics (
	ms_id VARCHAR(10) PRIMARY KEY,
    ms_idPlayer VARCHAR(10),
    ms_kills INT CHECK(ms_kills>=0),
    ms_deaths INT CHECK(ms_deaths>=0),
    ms_assists INT CHECK(ms_assists>=0),
    ms_idMatch VARCHAR(10),
    
    CONSTRAINT FOREIGN KEY (ms_idPlayer) REFERENCES Players(pl_id),
    CONSTRAINT FOREIGN KEY (ms_idMatch) REFERENCES Matchs(match_id)
);


-- Thêm cột giải thưởng
ALTER TABLE Matchs
ADD COLUMN prize DECIMAL(15,2) CHECK(prize >= 0);

-- Đổi tên quốc gai thành khu vực
ALTER TABLE Teams
RENAME COLUMN team_nation TO team_area;

-- Viết câu lệnh xóa bảng
DROP TABLE Match_Statistics;
DROP TABLE Matchs;

INSERT INTO Teams (team_id, team_name, team_area, team_owner, team_yearEstablish) VALUES
('MT001', 'TEAM A', 'Việt Nam', 'HLV Tran', 2010),
('MT002', 'TEAM B', 'Laos', 'HLV ABC', 2011),
('MT003', 'TEAM C', 'Indonesia', 'HLV LAOA', 2010),
('MT004', 'TEAM D', 'Japan', NULL, 2012),
('MT005', 'TEAM E', 'Malaisia', 'HLV Kiana', 2009);


INSERT INTO Players (pl_id, pl_name, pl_nickName, pl_position, pl_wage, pl_idTeam) VALUES 
('MP001', 'Tran Phong Long', Null, 'mid', 15000000, 'MT001'),
('MP002', 'Launa Sines', 'SinesA', 'support', 17999999, 'MT002'),
('MP003', 'Messi', 'SiLOL', 'top', 20899988, 'MT001'),
('MP004', 'Masua Peter', 'PeterPan', 'bot', 2000000, 'MT003'),
('MP005', 'Marry Hastric', Null, 'jungler', 10000000, 'MT004');

INSERT INTO Players (pl_id, pl_name, pl_nickName, pl_position, pl_wage) VALUES 
('MP006', 'Marry Hastric', Null, 'jungler', 75000000),
('MP007', 'Marry Hastric', Null, 'jungler', 80000000);



INSERT INTO Matchs (match_id, match_timeStart, match_ratio) VALUES
('MS001', '2025-05-02 19:00:00', '3:1'),
('MS002', '2025-06-12 19:00:00', '2:3'),
('MS003', '2025-05-01 18:30:00', '3:0'),
('MS004', '2025-06-02 19:00:00', '3:2'),
('MS007', '2025-05-02 15:20:00', '3:1'),
('MS005', '2025-05-02 22:30:00', '1:3');


INSERT INTO match_statistics (ms_id, ms_idPlayer, ms_kills, ms_deaths, ms_assists, ms_idMatch) VALUES
('MSS001', 'MP005', 6, 2, 3, 'MS001'),
('MSS002', 'MP003', 7, 5, 3, 'MS007'),
('MSS003', 'MP002', 3, 2, 6, 'MS004'),
('MSS004', 'MP002', 6, 0, 2, 'MS002'),
('MSS005', 'MP001', 0, 2, 3, 'MS001'),
('MSS006', 'MP001', 3, 2, 3, 'MS007'),
('MSS007', 'MP004', 6, 1, 0, 'MS003');


SET SQL_SAFE_UPDATES = 0;

UPDATE Players
SET pl_wage = pl_wage * 1.2
WHERE pl_position = 'jungler';

DELETE FROM Teams
WHERE team_owner IS NULL;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM Players
WHERE pl_wage >= 50000000 AND pl_wage <=150000000;


SELECT * FROM Matchs 
WHERE match_id = 'MS007';

-- Tìm danh sách player là cảu Vietnam(Việt Nam)
SELECT 
    p.pl_nickName, 
    p.pl_position, 
    t.team_area 
FROM Players p, Teams t
WHERE p.pl_idTeam = t.team_id 
AND t.team_area = 'Việt Nam';
  

