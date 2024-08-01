#
#  Dockerfile for a KDC-KADMIN
#

FROM ubuntu:jammy

EXPOSE 749 88

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y krb5-kdc krb5-admin-server krb5-config \
    && apt-get install -y iputils-ping \
    && apt-get install -y nano

ENV REALM ${REALM:-EXAMPLE.COM}
ENV SUPPORTED_ENCRYPTION_TYPES ${SUPPORTED_ENCRYPTION_TYPES:-aes256-cts-hmac-sha1-96:normal}
ENV KADMIN_PRINCIPAL ${KADMIN_PRINCIPAL:-kadmin/admin}
ENV KADMIN_PASSWORD ${KADMIN_PASSWORD:-MITiys4K5}
ENV GPADMIN_ADMIN_PRINCIPAL ${GPADMIN_ADMIN_PRINCIPAL:-gpadmin/admin}
ENV GPADMIN_ADMIN_PASSWORD ${GPADMIN_ADMIN_PASSWORD:-pivotal}
ENV GPADMIN_PRINCIPAL ${GPADMIN_PRINCIPAL:-gpadmin/kdc-kadmin}
ENV GPADMIN_PASSWORD ${GPADMIN_PASSWORD:-pivotal}
ENV POSTGRES_PRINCIPAL ${POSTGRES_PRINCIPAL:-postgres/gpdbsne.example.com}
ENV POSTGRES_PASSWORD ${POSTGRES_PASSWORD:-pivotal}

COPY entrypoint.sh /tmp/
CMD /tmp/entrypoint.sh
