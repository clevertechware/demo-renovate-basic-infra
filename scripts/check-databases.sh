#!/usr/bin/env bash
set -euo pipefail

psql_super() {
  docker compose exec -T postgres psql -U postgres -d postgres -tA -c "$1"
}

for name in factories plan; do
  owner=$(psql_super "SELECT pg_get_userbyid(datdba) FROM pg_database WHERE datname = '${name}'")
  if [ "${owner}" != "${name}" ]; then
    echo "base '${name}' absente ou propriétaire inattendu : '${owner}'" >&2
    exit 1
  fi

  docker compose exec -T -e PGPASSWORD="${name}" postgres \
    psql -h localhost -U "${name}" -d "${name}" -tA -c 'SELECT 1' >/dev/null
  echo "ok : base '${name}' appartient au rôle '${name}' et accepte sa connexion"
done
