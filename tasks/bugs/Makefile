MIGRATION_FILE=file://ent/migrations
ENT=ent://ent/schema
PROTOCOL=mysql://
USERNAME=root
PASSWORD=12345
DB_NAME=mydb
FILENAME=xyz.txt
HOSTNAME=localhost
PORT=3306
URL=mysql://root:abc12345@localhost:3306/promo

.PHONY: migration-gen migrate-status migrate
# make migration-gen

migration-gen:
 atlas migrate diff \
 --dir ${MIGRATION_FILE} \
 --to ${ENT} \
 --dev-url "${PROTOCOL}${USERNAME}${PASSWORD}@${HOSTNAME}:${PORT}/${DB_NAME}" \
$(FILENAME)
# make migrate-status URL=mysql://root:abc12345@localhost:3306/promo

migrate-status:
 atlas migrate status \
 --dir ${MIGRATION_FILE} \
 --url "$(URL)"

migrate:
 atlas migrate apply \
 --dir ${MIGRATION_FILE} \
 --url "$(URL)"
