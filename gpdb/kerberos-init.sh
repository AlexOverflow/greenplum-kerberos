#!/bin/bash

REALM_LOWER_CASE=$(echo "$REALM" | tr '[:upper:]' '[:lower:]')
tee /etc/krb5.conf <<EOF
[libdefaults]
	default_realm = $REALM
	allow_weak_crypto = true
	default_tkt_enctypes = aes256-cts aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 aes128-cts rc4-hmac des3-cbc-sha1 des-cbc-md5 des-cbc-crc arcfour-hmac arcfour-hmac-md5
  default_tgt_enctypes = aes256-cts aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 aes128-cts rc4-hmac des3-cbc-sha1 des-cbc-md5 des-cbc-crc arcfour-hmac arcfour-hmac-md5
  permitted_enctypes = aes256-cts aes256-cts-hmac-sha1-96 aes128-cts-hmac-sha1-96 aes128-cts rc4-hmac des3-cbc-sha1 des-cbc-md5 des-cbc-crc arcfour-hmac arcfour-hmac-md5
  forwardable=true
[realms]
	$REALM = {
		kdc = $KDC_HOST:88
		admin_server = $KDC_HOST
		default_domain = $REALM
	}
	[domain_realm]
   .$REALM_LOWER_CASE = $REALM
   $REALM_LOWER_CASE = $REALM

EOF
echo ""

tee /home/gpadmin/.java.login.config <<EOF
pgjdbc {
  com.sun.security.auth.module.Krb5LoginModule required
  doNotPrompt=true
  useTicketCache=true
  debug=true
  client=true;
};
EOF

kinit -k -t /code/gpdb-kerberos.keytab $POSTGRES_PRINCIPAL@$REALM
klist



#trap
while [ "$END" == '' ]; do
			sleep 1
			trap "gpstop -M && END=1" INT TERM
done
