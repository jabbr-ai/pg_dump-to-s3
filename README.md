# pg_dump-to-s3

Automatically dump and archive PostgreSQL backups to Amazon S3.

## Requirements

- [AWS cli](https://aws.amazon.com/cli): ```pip install awscli```


## Setup

- Rename `pg_dump-to-s3.conf.sample` to `pg_dump-to-s3.conf` and set your PostgreSQL's credentials and the list of databases to back up
   - Notice we're passing `PG_HOST` to the container, so just comment that line if you're using docker
   - Update PG credentials in `.env`
- Copy `.env.sample` to `.env` and update credentials
- If your PostgreSQL connection uses a password, you will need to store it in `~/.pgpass` ([read documentation](https://www.postgresql.org/docs/current/static/libpq-pgpass.html))

### Create .pgpass

```
*:5432:postgres:postgres:<PGPASSWORD>
```

```
chmod 600 .pgpass
```

## Usage with docker

We need to connect to the container running the database.

Use the correct docker image version for image that has the needed psql tools.

```
docker compose run --rm \
  -e PG_HOST=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' supabase-db) \
  backup
```

## Usage

```bash
./pg_dump-to-s3.sh

#  * Backup in progress.,.
#    -> backing up my_database_1...
#       ...database my_database_1 has been backed up
#    -> backing up my_database_2...
#       ...database my_database_2 has been backed up
#  * Deleting old backups...
#    -> Deleting 2018-05-24-at-03-10-01_my_database_1.dump
#    -> Deleting 2018-05-24-at-03-10-01_my_database_2.dump
#
# ...done!
```

## Restore a backup with docker

Copy the dump file to `pg_dump_file_to_restore.dump` and use docker compose

```
docker compose run --rm \
  -e PG_HOST=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' supabase-db) \
  restore
```

## Restore a backup

```bash
pg_restore -d DB_NAME -Fc --clean PATH_TO_YOUR_DB_DUMP_FILE
```
