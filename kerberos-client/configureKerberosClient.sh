#!/bin/bash
echo "==================================================================================="
echo "==== Kerberos Client =============================================================="
echo "==================================================================================="
KADMIN_PRINCIPAL_FULL=$KADMIN_PRINCIPAL@$REALM
POSTGRES_PRINCIPAL_FULL=$POSTGRES_PRINCIPAL@$REALM

echo "REALM: $REALM"
echo "KADMIN_PRINCIPAL_FULL: $KADMIN_PRINCIPAL_FULL"
echo "KADMIN_PASSWORD: $KADMIN_PASSWORD"
echo "POSTGRES_PRINCIPAL_FULL: $POSTGRES_PRINCIPAL_FULL"
echo ""

function kadminCommand {
    kadmin -p $KADMIN_PRINCIPAL_FULL -w $KADMIN_PASSWORD -q "$1"
}

echo "==================================================================================="
echo "==== /etc/krb5.conf ==============================================================="
echo "==================================================================================="

REALM_LOWER_CASE=$(echo "$REALM" | tr '[:upper:]' '[:lower:]')
tee /etc/krb5.conf <<EOF
[libdefaults]
	default_realm = $REALM
[realms]
	$REALM = {
		kdc = $KDC_HOST
		admin_server = $KDC_HOST
	}
	[domain_realm]
   .$REALM_LOWER_CASE = $REALM
   $REALM_LOWER_CASE = $REALM
EOF
echo ""

echo "==================================================================================="
echo "==== Testing ======================================================================"
echo "==================================================================================="
until kadminCommand "list_principals $KADMIN_PRINCIPAL_FULL"; do
  >&2 echo "KDC is unavailable - sleeping 1 sec"
  sleep 1
done
echo "KDC and Kadmin are operational"
echo ""

kinit -k -t /code/gpdb-kerberos.keytab $POSTGRES_PRINCIPAL_FULL
klist


