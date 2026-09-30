# FOOTORIA

Site web de recherche football + mode « club disparu ».

## 1. Installer

Python 3.11+ recommandé.

```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
# macOS/Linux: source .venv/bin/activate
pip install -r requirements.txt
```

## 2. Connecter ta DB

Le moteur est **SQL Server** (`données.sql` est écrit en T-SQL). Il faut :

1. Le driver ODBC système "ODBC Driver 18 for SQL Server" installé sur la machine qui lance Flask (pas installable via `pip`) : https://learn.microsoft.com/sql/connect/odbc/download-odbc-driver-for-sql-server
2. `pyodbc` (déjà dans `requirements.txt`)
3. Copier `.env.example` en `.env` et définir `DATABASE_URL`, ex. :
   `mssql+pyodbc://USER:PASSWORD@HOST:1433/footoria?driver=ODBC+Driver+18+for+SQL+Server&TrustServerCertificate=yes`
4. Exécuter `données.sql` sur ton instance SQL Server (il crée et remplit `Equipe`, `competition`, `Joueurs`) avant de lancer l'app.

Schéma réel (celui de `projet-141-ilyass-chelli.sql`, qui crée aussi la base `footoria`) :

- `Equipe(id_equipe PK, nom_des_equipes, pays_des_equipes, Ville_des_equipes)`
- `competition(id_competition PK, nom, pays)`
- `match_(id_match PK, date_match, composition_match, Lieu, id_competition FK → competition)`
- `Joueurs(id_joueur PK, nom, prenom, age, poste, id_equipe FK → Equipe)`
- `qualifier(id_equipe, id_competition, PK composite, FK → Equipe et competition)` — quels clubs sont inscrits à quels championnats
- `marquer(id_joueur, id_match, PK composite, FK → Joueurs et match_)` — quels joueurs ont marqué dans quels matchs

**Important :** exécute d'abord `projet-141-ilyass-chelli.sql` (crée la base et les 6 tables avec leurs clés étrangères), puis `données.sql` (remplit `Equipe`, `competition`, `Joueurs` — mais pas encore `match_`, `qualifier` ni `marquer`, à générer si tu veux que les missions 4-6 renvoient des résultats). Les missions du terminal SQL (`app.py`) utilisent bien les vraies FK (`qualifier`, `marquer`) plutôt qu'un rapprochement par pays.

`app.py` lui-même ne fait aucune hypothèse de schéma câblée en dur (le terminal exécute directement le SQL tapé par l'utilisateur) : rien d'autre à modifier si tu changes des noms de colonnes, seuls les textes des missions doivent rester cohérents.

## 3. Index pour 10M+ lignes

Pour une recherche rapide sur SQL Server, ajoute au minimum :

```sql
CREATE INDEX idx_joueurs_nom ON Joueurs(nom);
CREATE INDEX idx_joueurs_prenom ON Joueurs(prenom);
CREATE INDEX idx_joueurs_id_equipe ON Joueurs(id_equipe);
CREATE INDEX idx_joueurs_poste ON Joueurs(poste);
CREATE INDEX idx_match_id_competition ON match_(id_competition);
CREATE INDEX idx_marquer_id_joueur ON marquer(id_joueur);
CREATE INDEX idx_marquer_id_match ON marquer(id_match);
CREATE INDEX idx_qualifier_id_equipe ON qualifier(id_equipe);
CREATE INDEX idx_qualifier_id_competition ON qualifier(id_competition);
```

Les PRIMARY KEY composites de `qualifier` et `marquer` créent déjà un index sur `(id_equipe, id_competition)` et `(id_joueur, id_match)` — les index ci-dessus couvrent le sens inverse des jointures.

Pour une recherche « contient » (`LIKE '%...%'`) rapide sur 10M de lignes, envisage un index Full-Text SQL Server sur `Joueurs.nom` / `Joueurs.prenom`.

## 4. Lancer

```bash
python app.py
```

Puis ouvrir `http://localhost:5000`.

## 5. Suite recommandée

Quand tu fournis le schéma/export de ta DB, adapter `app.py` exactement à tes tables. Ensuite on peut ajouter :

- authentification / comptes joueurs ;
- score et chronomètre ;
- plusieurs niveaux de difficulté ;
- indices progressifs ;
- classement ;
- génération de clubs disparus contrôlée ;
- API optimisée pour les 10 millions de lignes ;
- Docker + déploiement.


## Frontend v2
Le frontend a été refait à partir de l'image de référence fournie : thème noir/rouge, carte, effet dossier d'archives, typographie horror, console de recherche et mode club disparu. L'image de référence est incluse dans `static/footoria-reference.jpg`.


## Version SQL Investigation

Le site a maintenant un **terminal SQL** : l'utilisateur choisit une mission, écrit sa propre requête, l'exécute et voit le résultat.

### Sécurité

Le endpoint `/api/sql` refuse les instructions d'écriture/DDL et les requêtes multiples. Pour un vrai déploiement, utilise impérativement un compte DB **lecture seule**, plus un timeout de requête côté SGBD.

### Schéma

Les 6 missions sont adaptées au vrai schéma relationnel de `projet-141-ilyass-chelli.sql` :

- `Equipe(id_equipe, nom_des_equipes, pays_des_equipes, Ville_des_equipes)`
- `competition(id_competition, nom, pays)`
- `match_(id_match, date_match, composition_match, Lieu, id_competition)`
- `Joueurs(id_joueur, nom, prenom, age, poste, id_equipe)`
- `qualifier(id_equipe, id_competition)` — clubs inscrits aux championnats
- `marquer(id_joueur, id_match)` — buteurs par match

La mission « championnats » utilise la vraie FK via `qualifier`, et la mission « matchs effacés » utilise la vraie FK via `marquer` + `match_`.
