#!/bin/bash

########################################################################
# graphite-archive.sh                                                  #
########################################################################

DATE=`date +'%Y%m%d'`   # YYYYMMDD
DOW=`date +'%w'`        # day of week
WOY=`date +'%W'`        # week of year
DATE=`date +'%d'`       # day of month
WEEKNUM=$(($WOY%5))     # the week that we are backing up
                        # beauty of this is that this number rotates
                        # 0-4 so you do not need to do any manual deletes
                        # of old backups

# copy our crap to the /tmp folder so we don't mess up any backups in place
tar -cvzf /tmp/graphite.archive.${DOW}.tgz /opt/graphite/storage

# now replace the existing backup file with mv, this is atomic
# (assuming /tmp and /var/lib/graphite-archive are on the same partition)
mv /tmp/graphite.archive.${DOW}.tgz /var/lib/graphite-archive/graphite.archive.${DOW}.tgz

/usr/bin/s3cmd sync /var/lib/graphite-archive/ s3://sendgrid-ops/$(hostname --fqdn)/graphite-archive/