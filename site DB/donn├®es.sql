USE footoria;
GO

/* =========================================================
   1. 100 EQUIPES
   ========================================================= */

INSERT INTO Equipe (id_equipe, nom_des_equipes, pays_des_equipes, Ville_des_equipes)
VALUES
('EQ001','Real Madrid','Espagne','Madrid'),
('EQ002','FC Barcelona','Espagne','Barcelona'),
('EQ003','Atletico Madrid','Espagne','Madrid'),
('EQ004','Sevilla FC','Espagne','Sevilla'),
('EQ005','Valencia CF','Espagne','Valencia'),
('EQ006','Athletic Bilbao','Espagne','Bilbao'),
('EQ007','Villarreal CF','Espagne','Villarreal'),
('EQ008','Real Sociedad','Espagne','San Sebastian'),
('EQ009','Real Betis','Espagne','Seville'),
('EQ010','Celta Vigo','Espagne','Vigo'),

('EQ011','Manchester City','Angleterre','Manchester'),
('EQ012','Manchester United','Angleterre','Manchester'),
('EQ013','Liverpool FC','Angleterre','Liverpool'),
('EQ014','Arsenal FC','Angleterre','London'),
('EQ015','Chelsea FC','Angleterre','London'),
('EQ016','Tottenham Hotspur','Angleterre','London'),
('EQ017','Newcastle United','Angleterre','Newcastle'),
('EQ018','Aston Villa','Angleterre','Birmingham'),
('EQ019','West Ham United','Angleterre','London'),
('EQ020','Everton FC','Angleterre','Liverpool'),

('EQ021','Bayern Munich','Allemagne','Munich'),
('EQ022','Borussia Dortmund','Allemagne','Dortmund'),
('EQ023','RB Leipzig','Allemagne','Leipzig'),
('EQ024','Bayer Leverkusen','Allemagne','Leverkusen'),
('EQ025','Eintracht Frankfurt','Allemagne','Frankfurt'),
('EQ026','Schalke 04','Allemagne','Gelsenkirchen'),
('EQ027','VfB Stuttgart','Allemagne','Stuttgart'),
('EQ028','Werder Bremen','Allemagne','Bremen'),
('EQ029','Borussia Monchengladbach','Allemagne','Monchengladbach'),
('EQ030','Hertha Berlin','Allemagne','Berlin'),

('EQ031','PSG','France','Paris'),
('EQ032','Olympique Marseille','France','Marseille'),
('EQ033','Olympique Lyonnais','France','Lyon'),
('EQ034','AS Monaco','France','Monaco'),
('EQ035','Lille OSC','France','Lille'),
('EQ036','OGC Nice','France','Nice'),
('EQ037','RC Lens','France','Lens'),
('EQ038','FC Nantes','France','Nantes'),
('EQ039','Stade Rennais','France','Rennes'),
('EQ040','Montpellier HSC','France','Montpellier'),

('EQ041','Juventus','Italie','Turin'),
('EQ042','Inter Milan','Italie','Milan'),
('EQ043','AC Milan','Italie','Milan'),
('EQ044','AS Roma','Italie','Rome'),
('EQ045','Lazio Rome','Italie','Rome'),
('EQ046','Napoli','Italie','Naples'),
('EQ047','Atalanta','Italie','Bergame'),
('EQ048','Fiorentina','Italie','Florence'),
('EQ049','Torino FC','Italie','Turin'),
('EQ050','Bologna FC','Italie','Bologna'),

('EQ051','Ajax','Pays-Bas','Amsterdam'),
('EQ052','PSV Eindhoven','Pays-Bas','Eindhoven'),
('EQ053','Feyenoord','Pays-Bas','Rotterdam'),
('EQ054','AZ Alkmaar','Pays-Bas','Alkmaar'),
('EQ055','FC Twente','Pays-Bas','Enschede'),
('EQ056','FC Utrecht','Pays-Bas','Utrecht'),
('EQ057','Vitesse','Pays-Bas','Arnhem'),
('EQ058','Groningen','Pays-Bas','Groningen'),
('EQ059','Heerenveen','Pays-Bas','Heerenveen'),
('EQ060','Sparta Rotterdam','Pays-Bas','Rotterdam'),

('EQ061','Benfica','Portugal','Lisbonne'),
('EQ062','FC Porto','Portugal','Porto'),
('EQ063','Sporting CP','Portugal','Lisbonne'),
('EQ064','Braga','Portugal','Braga'),
('EQ065','Vitoria Guimaraes','Portugal','Guimaraes'),
('EQ066','Boavista','Portugal','Porto'),
('EQ067','Maritimo','Portugal','Funchal'),
('EQ068','Rio Ave','Portugal','Vila do Conde'),
('EQ069','Famalicao','Portugal','Famalicao'),
('EQ070','Gil Vicente','Portugal','Barcelos'),

('EQ071','Galatasaray','Turquie','Istanbul'),
('EQ072','Fenerbahce','Turquie','Istanbul'),
('EQ073','Besiktas','Turquie','Istanbul'),
('EQ074','Trabzonspor','Turquie','Trabzon'),
('EQ075','Basaksehir','Turquie','Istanbul'),
('EQ076','Antalyaspor','Turquie','Antalya'),
('EQ077','Sivasspor','Turquie','Sivas'),
('EQ078','Kasimpasa','Turquie','Istanbul'),
('EQ079','Konyaspor','Turquie','Konya'),
('EQ080','Alanyaspor','Turquie','Alanya'),

('EQ081','Ajax Riviera','Suisse','Lausanne'),
('EQ082','FC Lausanne','Suisse','Lausanne'),
('EQ083','Servette FC','Suisse','Geneve'),
('EQ084','FC Basel','Suisse','Basel'),
('EQ085','Young Boys','Suisse','Bern'),
('EQ086','FC Zurich','Suisse','Zurich'),
('EQ087','FC Lugano','Suisse','Lugano'),
('EQ088','FC Sion','Suisse','Sion'),
('EQ089','FC Luzern','Suisse','Luzern'),
('EQ090','FC Winterthur','Suisse','Winterthur'),

('EQ091','Flamengo','Bresil','Rio de Janeiro'),
('EQ092','Palmeiras','Bresil','Sao Paulo'),
('EQ093','Santos FC','Bresil','Santos'),
('EQ094','Corinthians','Bresil','Sao Paulo'),
('EQ095','Sao Paulo FC','Bresil','Sao Paulo'),
('EQ096','Gremio','Bresil','Porto Alegre'),
('EQ097','Internacional','Bresil','Porto Alegre'),
('EQ098','Botafogo','Bresil','Rio de Janeiro'),
('EQ099','Vasco da Gama','Bresil','Rio de Janeiro'),
('EQ100','Cruzeiro','Bresil','Belo Horizonte');
GO


/* =========================================================
   2. 100 COMPETITIONS
   ========================================================= */

;WITH N AS
(
    SELECT TOP (100)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
)
INSERT INTO competition (id_competition, nom, pays)
SELECT
    'COMP' + RIGHT('000' + CAST(n AS VARCHAR(3)),3),
    CASE 
        WHEN n % 5 = 1 THEN 'Championnat National'
        WHEN n % 5 = 2 THEN 'Coupe Nationale'
        WHEN n % 5 = 3 THEN 'Ligue Professionnelle'
        WHEN n % 5 = 4 THEN 'Super Coupe'
        ELSE 'Coupe Internationale'
    END + ' ' + CAST(n AS VARCHAR(3)),
    CASE 
        WHEN n <= 10 THEN 'Espagne'
        WHEN n <= 20 THEN 'Angleterre'
        WHEN n <= 30 THEN 'Allemagne'
        WHEN n <= 40 THEN 'France'
        WHEN n <= 50 THEN 'Italie'
        WHEN n <= 60 THEN 'Pays-Bas'
        WHEN n <= 70 THEN 'Portugal'
        WHEN n <= 80 THEN 'Turquie'
        WHEN n <= 90 THEN 'Suisse'
        ELSE 'Bresil'
    END
FROM N;
GO


/* =========================================================
   3. TABLES TEMPORAIRES DE NOMS ET PRENOMS
   ========================================================= */

CREATE TABLE #Prenoms
(
    id INT IDENTITY(1,1),
    prenom VARCHAR(50)
);

INSERT INTO #Prenoms (prenom)
VALUES
('Lucas'),('Hugo'),('Gabriel'),('Leo'),('Louis'),
('Arthur'),('Jules'),('Nathan'),('Adam'),('Ethan'),
('Thomas'),('Noah'),('Enzo'),('Mathis'),('Antoine'),
('Maxime'),('Alexandre'),('Raphael'),('Theo'),('Paul'),
('Julien'),('Nicolas'),('Victor'),('Samuel'),('Rayan'),
('Yanis'),('Ilyes'),('Amine'),('Mehdi'),('Karim'),
('Sami'),('Adel'),('Bilal'),('Nassim'),('Sofiane'),
('Ayoub'),('Ismael'),('Omar'),('Mohamed'),('Ibrahim'),
('Daniel'),('David'),('Kevin'),('Alex'),('Martin'),
('Benjamin'),('Elias'),('Liam'),('Oscar'),('Felix'),
('Marco'),('Antonio'),('Diego'),('Miguel'),('Carlos'),
('Mateo'),('Javier'),('Enrique'),('Pablo'),('Sergio'),
('Julian'),('Adrian'),('Alvaro'),('Rodrigo'),('Fernando'),
('Ricardo'),('Andres'),('Rafael'),('Bruno'),('Tiago'),
('Joao'),('Diogo'),('Andre'),('Pedro'),('Luis'),
('Marco'),('Lorenzo'),('Matteo'),('Andrea'),('Luca'),
('Giovanni'),('Francesco'),('Davide'),('Stefano'),('Fabio'),
('Nabil'),('Walid'),('Hicham'),('Anis'),('Zakaria'),
('Moussa'),('Khalil'),('Samir'),('Kamel'),('Reda'),
('Youssef'),('Aymen'),('Fares'),('Tarek'),('Brahim');


CREATE TABLE #Noms
(
    id INT IDENTITY(1,1),
    nom VARCHAR(50)
);

INSERT INTO #Noms (nom)
VALUES
('Martin'),('Bernard'),('Dubois'),('Thomas'),('Robert'),
('Richard'),('Petit'),('Durand'),('Leroy'),('Moreau'),
('Simon'),('Laurent'),('Lefebvre'),('Michel'),('Garcia'),
('David'),('Bertrand'),('Roux'),('Vincent'),('Fournier'),
('Morel'),('Girard'),('Andre'),('Mercier'),('Dupont'),
('Lambert'),('Bonnet'),('Francois'),('Martinez'),('Legrand'),
('Garnier'),('Faure'),('Rousseau'),('Blanc'),('Guerin'),
('Muller'),('Henry'),('Roussel'),('Nicolas'),('Perrin'),
('Morin'),('Mathieu'),('Clement'),('Gauthier'),('Dumont'),
('Lopez'),('Fontaine'),('Chevalier'),('Robin'),('Masson'),
('Sanchez'),('Boyer'),('Denis'),('Lemaire'),('Duval'),
('Joly'),('Gautier'),('Roger'),('Roy'),('Noel'),
('Meyer'),('Lucas'),('Meunier'),('Jean'),('Perez'),
('Marchand'),('Dufour'),('Blanchard'),('Marie'),('Barbier'),
('Brun'),('Arnaud'),('Picard'),('Leclerc'),('Paris'),
('Renard'),('Schmitt'),('Lacroix'),('Colin'),('Vidal'),
('Alves'),('Silva'),('Santos'),('Costa'),('Pereira'),
('Fernandes'),('Oliveira'),('Rodrigues'),('Carvalho'),('Gomes'),
('Martins'),('Ribeiro'),('Sousa'),('Mendes'),('Correia'),
('Ferreira'),('Moreira'),('Nunes'),('Teixeira'),('Dias'),
('Benali'),('Bensaid'),('Belkacem'),('Bouzid'),('Saidi'),
('Mansouri'),('Khelifi'),('Haddad'),('Amara'),('Rahmani');
GO


/* =========================================================
   4. 10 000 000 JOUEURS
   ========================================================= */

;WITH
N AS
(
    SELECT TOP (10000000)
        ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a
    CROSS JOIN sys.all_objects b
    CROSS JOIN
    (
        SELECT 1 AS x
        UNION ALL SELECT 2
        UNION ALL SELECT 3
        UNION ALL SELECT 4
        UNION ALL SELECT 5
        UNION ALL SELECT 6
        UNION ALL SELECT 7
        UNION ALL SELECT 8
        UNION ALL SELECT 9
        UNION ALL SELECT 10
    ) c
)
INSERT INTO Joueurs
(
    id_joueur,
    nom,
    prenom,
    age,
    poste,
    id_equipe
)
SELECT
    'J' + RIGHT('00000000' + CAST(n AS VARCHAR(8)),8),

    nom.nom,

    prenom.prenom,

    16 + ((n * 17) % 25),

    CASE (n % 4)
        WHEN 0 THEN 'Gardien'
        WHEN 1 THEN 'Defenseur'
        WHEN 2 THEN 'Milieu'
        WHEN 3 THEN 'Attaquant'
    END,

    'EQ' + RIGHT('000' + CAST(((n - 1) % 100) + 1 AS VARCHAR(3)),3)

FROM N
CROSS APPLY
(
    SELECT prenom
    FROM #Prenoms
    WHERE id = ((n - 1) % 100) + 1
) prenom
CROSS APPLY
(
    SELECT nom
    FROM #Noms
    WHERE id = (((n - 1) / 100) % 100) + 1
) nom;
GO


/* =========================================================
   5. VERIFICATION
   ========================================================= */

SELECT COUNT(*) AS Nombre_Joueurs
FROM Joueurs;

SELECT COUNT(*) AS Nombre_Equipes
FROM Equipe;

SELECT COUNT(*) AS Nombre_Competitions
FROM competition;
GO