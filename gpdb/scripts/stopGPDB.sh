#!/bin/bash

export MASTER_DATA_DIRECTORY=/data/master/gpsne-1
source /usr/local/greenplum-db/greenplum_path.sh
gpstop -a
