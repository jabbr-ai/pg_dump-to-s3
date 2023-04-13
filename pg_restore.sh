#!/bin/bash

set -e

pg_restore -d ${PG_DB} -h ${PG_HOST} -p ${PG_PORT} -U ${PG_USER} \
	--exit-on-error \
	-Fc \
	--clean \
	/root/pg_dump_file.dump
