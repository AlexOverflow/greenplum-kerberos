#!/bin/bash
export STATUS=0
i=0
echo "STARTING... (about 30 sec)"
while [[ $STATUS -eq 0 ]] || [[ $i -lt 30 ]]; do
	sleep 1
	i=$((i+1))
	STATUS=$(grep -r -i --include \*.log "Database successfully started" | wc -l)
done

echo "STARTED"

source /home/gpadmin/.bash_profile
/opt/greenplum-db-6.8.1/bin/psql -v ON_ERROR_STOP=1 --username gpadmin --dbname postgres <<-EOSQL
CREATE ROLE "$POSTGRES_PRINCIPAL@$REALM" SUPERUSER;
ALTER ROLE "$POSTGRES_PRINCIPAL@$REALM" WITH LOGIN;
EOSQL

cat << EOF
+-------------------------------------------------
|  CREATE ROLE $POSTGRES_PRINCIPAL@$REALM SUPERUSER;
+-------------------------------------------------
EOF
