# demo-renovate-basic-infra

Instance Postgres partagée par `service-factories` et `service-plan`. Dépôt de démo de la série sur Renovate : l'image
`postgres:16.4` et `actions/checkout@v4` sont volontairement anciennes pour que Renovate propose des mises à jour.

Le superutilisateur `postgres` / `postgres` est réservé à la démo locale.

## Prérequis

Docker avec Compose v2.

## Lancer

```bash
docker compose up --detach --wait
```

`initdb/01-databases.sql` crée les rôles et bases `factories` (mot de passe `factories`) et `plan` (mot de passe `plan`).
Le script ne s'exécute qu'à l'initialisation du volume.

## Tester

```bash
docker compose config --quiet
scripts/check-databases.sh
docker compose down --volumes
```

## Renovate

`renovate.json` étend `config:recommended`. `.github/workflows/renovate.yml` exige la variable `RENOVATE_APP_CLIENT_ID` et
le secret `RENOVATE_APP_PRIVATE_KEY` d'une GitHub App Renovate installée sur le dépôt.
