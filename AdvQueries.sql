--advanced queries like 9-10---------------

-- joins players clubs and stadium table
SELECT players.p_name, clubs.c_name, stadium.stadium_name
FROM players
INNER JOIN clubs ON players.club_fk = clubs.club_id
INNER JOIN stadium ON stadium.club_id = clubs.club_id;


--matches player name club and managers
SELECT players.p_name, clubs.c_name, managers.m_name
FROM players
INNER JOIN clubs ON players.club_fk = clubs.club_id
INNER JOIN managers ON managers.clubid_fk = clubs.club_id
ORDER BY c_name;


--find home club match id number stadium name and ref name
SELECT clubs.c_name, matchesPlayed.fk_match_id ,stadium.stadium_name,
referees.ref_name
FROM matchesPlayed
INNER JOIN clubs ON clubs.club_id= matchesPlayed.fk_club_home
INNER JOIN stadium ON clubs.club_id=stadium.club_id
INNER JOIN matchess ON matchess.match_id = matchesPlayed.fk_match_id
INNER JOIN referees ON matchess.fk_gameRef =referees.ref_id ;


--views------------------------

--players name and shirt number and club id only
CREATE VIEW player_view AS
SELECT p_name, shirt_#, club_fk
FROM players
WHERE managerid_fk <> 'M1';

SELECT * FROM player_view;


-- manager name club and age
CREATE VIEW manager_view AS
SELECT m_name, clubid_fk, age
FROM managers
WHERE manager_id <> 'M7'
ORDER BY age;

SELECT * FROM manager_view;


-- clubs name jerseys and country name
CREATE VIEW clubs_view AS
SELECT c_name, home_jersey_color, away_jersey_color, country_fk
FROM clubs
ORDER BY home_jersey_color;

SELECT * FROM clubs_view;




--advanced queries like 11-23---------------




-- counts all players in by thier postions
SELECT COUNT(player_id), p_position 
FROM players
GROUP BY p_position;

--average age of players
SELECT AVG(age)
From players;


--players name and age between 20 and 35
SELECT p_name, age 
FROM players 
WHERE age between 20 and 35
ORDER BY club_fk;

-- select players who are st but not players whos shirt number >= 8
SELECT p_name
FROM players p
WHERE p_position = 'ST'
    AND NOT EXISTS
        (SELECT *
        FROM players pp
        WHERE shirt_# >= 8
        AND p.p_name = pp.p_name);


----select club names starting with that and ending doesnt matter
SELECT * 
FROM clubs
WHERE c_name LIKE 'Manchester%'
OR     c_name LIKE 'A%';

--player and manager list in 1
SELECT p_name FROM players 
UNION
SELECT m_name FROM managers
ORDER BY p_name;



SELECT match_id,gameday FROM matchess
WHERE  fk_gameref = 'r1'
AND EXISTS
    (SELECT fk_match_id FROM   matchesplayed
     WHERE  fk_club_home = 'C1'
     AND matchess.match_id = matchesplayed.fk_match_id);


SELECT AVG(Age) AS Age , p_name AS Name
FROM players
GROUP BY p_name
HAVING AVG(Age) > (SELECT  AVG(Age)
                  FROM  players)
UNION
SELECT AVG(Age), m_name AS Name
FROM managers
GROUP BY m_name
HAVING AVG(Age)< (SELECT  AVG(Age)
                  FROM  managers);