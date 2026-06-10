## In the below Makefile, there are few bugs, find it and fix it. 

MIGRATION_FILE file://ent/migrations
ENT = ent://ent/schema
PROTOCOL=mysql://
USERNAME = root


PHONY: migration-gen migrate-status migrate
# make migration-gen

migration-gen
 atlas migrate diff \
 --dir ${MIGRATION_FILE} \
 --to ${ENT} \
 --dev-url "${PROTOCOL}${USERNAME}${PASSWORD}@${HOSTNAME}:${PORT}/${DB_NAME}" \
$(FILENAME)
# make migrate-status URL=mysql://root:abc12345@localhost:3306/promo

migrate-status
 atlas migrate status \
 --dir "file://ent/migrations" \
 --url "$(URL)"

migrate
 atlas migrate apply \
 --dir "file://ent/migrations" \
 --url "$(URL)"
