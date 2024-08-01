#
#  Dockerfile for a KDC-KADMIN
#

FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install krb5-user postgresql-client -y \
    && apt-get install -y iputils-ping \
    && apt-get install -y nano

ENV REALM ${REALM:-EXAMPLE.COM}
ENV KADMIN_PRINCIPAL ${KADMIN_PRINCIPAL:-kadmin/admin}
ENV KADMIN_PASSWORD ${KADMIN_PASSWORD:-MITiys4K5}
ENV GPADMIN_ADMIN_PRINCIPAL ${GPADMIN_PRINCIPAL:-gpadmin/admin}
ENV GPADMIN_ADMIN_PASSWORD ${GPADMIN_PASSWORD:-pivotal}
ENV GPADMIN_PRINCIPAL ${GPADMIN_PRINCIPAL:-gpadmin/kdc-kadmin}
ENV GPADMIN_PASSWORD ${GPADMIN_PASSWORD:-pivotal}
ENV POSTGRES_PRINCIPAL ${POSTGRES_PRINCIPAL:-postgres/gpdbsne.example.com}
ENV POSTGRES_PASSWORD ${POSTGRES_PASSWORD:-pivotal}

COPY entrypoint.sh configureKerberosClient.sh /tmp/
CMD /tmp/entrypoint.sh
