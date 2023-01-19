--soccer dbms

CREATE TABLE players (
    player_id   VARCHAR2(2 CHAR),
    p_name      VARCHAR2(30 CHAR) NOT NULL,
    age         NUMBER,
    p_position  VARCHAR2(2 CHAR),
    shirt_#     NUMBER CHECK (shirt_# >=0 AND shirt_# <=99),
    managerid_fk  VARCHAR2(2 CHAR), --fk
    club_fk     VARCHAR2(2 CHAR), --fk
    CONSTRAINT  player_pk PRIMARY KEY (player_id)
);

-- ADD after i create manager and club to show relatioship
ALTER TABLE players
ADD FOREIGN KEY (managerid_fk) REFERENCES managers(manager_id)
ADD FOREIGN KEY (club_fk) REFERENCES clubs(club_id);


CREATE TABLE managers (
    manager_id   VARCHAR2(2 CHAR),
    m_name      VARCHAR2(30 CHAR) NOT NULL,
    age         NUMBER,
    clubid_fk    VARCHAR2(2 CHAR), --fk
    CONSTRAINT  managerid_pk PRIMARY KEY (manager_id)
);
--ADD after i create club to show relatioship
ALTER TABLE managers 
ADD FOREIGN KEY (clubid_fk) REFERENCES clubs(club_id);


CREATE TABLE clubs (
    club_id               VARCHAR2(2 CHAR),
    c_name                VARCHAR2(30 CHAR) NOT NULL,
    home_jersey_color     VARCHAR2(30 CHAR),
    away_jersey_color     VARCHAR2(30 CHAR),
    country_fk             VARCHAR2(30 CHAR), --fk
    CONSTRAINT  clubid_pk PRIMARY KEY (club_id)
);
--ADD after i create league table to show relatioship
ALTER TABLE clubs 
ADD FOREIGN KEY (country_fk) REFERENCES league(country);


CREATE TABLE league (
    country         VARCHAR2(30 CHAR),
    leagueName      VARCHAR2(30 CHAR) NOT NULL,
    CONSTRAINT country_pk PRIMARY KEY (country)
);

-- add after i made clubs table
CREATE TABLE stadium (
        club_id               VARCHAR2(2 CHAR) PRIMARY KEY, --same key as club
        stadium_name          VARCHAR2(30 CHAR) NOT NULL,
        city                  VARCHAR2(30 CHAR) NOT NULL,
        CONSTRAINT clubid_fk FOREIGN KEY (club_id) REFERENCES clubs(club_id)
        
);

CREATE TABLE referees (
        ref_id         VARCHAR2(2 CHAR),
        ref_name       VARCHAR2(30 CHAR) NOT NULL,
        CONSTRAINT ref_pk PRIMARY KEY (ref_id)
        
);

CREATE TABLE matchess (
        match_id    VARCHAR2(2 CHAR),
        GameDay     DATE,
        fk_gameRef  VARCHAR2(2 CHAR) NOT NULL,
        FOREIGN KEY (fk_gameRef) REFERENCES referees(ref_id),
        CONSTRAINT uc_ref_for_game  UNIQUE (fk_gameRef,GameDay),
        CONSTRAINT match_pk PRIMARY KEY (match_id)
        --NO REF CAN REFEREE 2 GAMES ONE DAY
        );
      

--ad table bacl
CREATE TABLE matchesPlayed (
            fk_match_id     VARCHAR2(2 CHAR) NOT NULL,
            fk_club_home    VARCHAR2(2 CHAR) NOT NULL,
            fk_club_away    VARCHAR2(2 CHAR) NOT NULL,
            FOREIGN KEY (fk_match_id) REFERENCES matchess(match_id ),
            FOREIGN KEY (fk_club_home) REFERENCES clubs(club_id),
            FOREIGN KEY (fk_club_away) REFERENCES clubs(club_id)
            --CONSTRAINT CHECK (fk_club_home != fk_club_away)
        );
--DROP TABLE matchesPlayed;

DESCRIBE players
DESCRIBE managers
DESCRIBE clubs          -- done adding
DESCRIBE stadium        -- done adding
DESCRIBE league         -- done adding
DESCRIBE referees       -- done adding
    
DESCRIBE matchess       -- done adding
DESCRIBE matchesPlayed  -- add table and people in it
--matches table
--match id and club id , club id table



INSERT INTO referees VALUES ('r1', 'Michael Oliver');
INSERT INTO referees VALUES ('r2', 'Mike Dean');
INSERT INTO referees VALUES ('r3', 'Anthony Taylor');
INSERT INTO referees VALUES ('r4', 'Howard Webb');
INSERT INTO referees VALUES ('r5', 'Antonio Mateu Lahoz');
SELECT * FROM referees;



INSERT INTO league VALUES ('England', 'Premier League' );
INSERT INTO league VALUES ('Spain', 'La Liga' );
INSERT INTO league VALUES ('Italy', 'Serie A' );
INSERT INTO league VALUES ('France', 'Ligue One' );
INSERT INTO league VALUES ('Germany', 'Bundesliga' );
SELECT * FROM league;


INSERT INTO matchess VALUES ('M1', '2022-10-10', 'r1');
INSERT INTO matchess VALUES ('M2', '2022-10-17', 'r1');
INSERT INTO matchess VALUES ('M3', '2022-10-10', 'r2');
SELECT * FROM matchess;


INSERT INTO clubs VALUES('C1','Manchester united','Red','White','England');
INSERT INTO clubs VALUES('C2','Arsenal','Red','Black','England');
INSERT INTO clubs VALUES('C3','PSG','Blue','White','France');
INSERT INTO clubs VALUES('C4','Real Madrid','White','Purple','Spain');
INSERT INTO clubs VALUES('C5','Manchester City','Blue','White','England');
SELECT * FROM clubs;


INSERT INTO stadium VALUES('C3','Le Parc Des Princes','Paris');
INSERT INTO stadium VALUES('C1','Old Trafford','Manchester');
--DELETE FROM stadium WHERE club_id='C2';
INSERT INTO stadium VALUES('C2','Emirates','London');
INSERT INTO stadium VALUES('C4','Bernabeu','Madrid');
INSERT INTO stadium VALUES('C5','Ethihad','Manchester');
SELECT * FROM stadium;


INSERT INTO managers VALUES('M1','Pep Guardiola','51','C5');
INSERT INTO managers VALUES('M2','mauricio pochettino','50','C3');
INSERT INTO managers VALUES('M3','carlo ancelotti','63','C4');
INSERT INTO managers VALUES('M4','Eric ten hag','52','C1');
INSERT INTO managers VALUES('M5','Mike arteta','40','C2');
SELECT * FROM managers;


INSERT INTO players VALUES('P1','Cristiano Ronaldo','38','ST','7','M4','C1');
INSERT INTO players VALUES('P2','Lionel Messi','36','RW','30','M2','C3');
INSERT INTO players VALUES('P3','Eric Halland','22','ST','9','M1','C5');
INSERT INTO players VALUES('P4','Neymar','29','LW','10','M2','C3');
INSERT INTO players VALUES('P5','Karim Benzema','33','ST','9','M3','C4');
SELECT * FROM players
