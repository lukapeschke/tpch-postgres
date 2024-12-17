# TPCH data for postgres

Usage:

```bash
# Clone this repo recursively
git clone --recursive git@github.com/lukapeschke/tpch-postgres.git
# cd to it
cd tpch-postgres
# First time only, generate the data and prepare it for postgres ingestion
make prepare-pg-data
# Start postgres (first startup might take 10-20s as data gets copied from the
# CSVS into the postgres database)
docker compose up -d
# Connect to postgres
docker compose exec postgres psql postgres://user:password@localhost/tpch
```
