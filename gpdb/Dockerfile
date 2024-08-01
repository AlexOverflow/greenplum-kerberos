FROM datagrip/greenplum:6.8

#COPY sources.list /etc/apt/sources.list

ARG DEBIAN_FRONTEND=noninteractive

RUN rm etc/apt/sources.list.d/greenplum-ubuntu-db-bionic.list

## Install Kerberos5 client
RUN apt-get update \
&& apt-get install krb5-user -y \
&& apt-get install -y iputils-ping \
&& apt-get install -y nano


COPY entrypoint.sh /
COPY kerberos-init.sh /
COPY install_and_start_gpdb.sh /home/gpadmin/install_and_start_gpdb.sh
RUN chmod +x /entrypoint.sh
RUN chmod +x /kerberos-init.sh
RUN chmod +x /home/gpadmin/install_and_start_gpdb.sh

CMD /etc/init.d/ssh start \
    && su - gpadmin bash -c /home/gpadmin/install_and_start_gpdb.sh \
    && su --preserve-environment gpadmin bash -c /entrypoint.sh \
    && bash -c /kerberos-init.sh \
    && tail -f /dev/null

#RUN chown -R gpadmin: /home/gpadmin
# Define default command.
