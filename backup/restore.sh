#!/bin/sh

BASEDIR=/var/backup/restore

# check if restore file exists
if [ ! -f $BASEDIR/backup.stream.gz  ]; then
    echo "File not found"
    exit 1
fi

if [ -d /var/lib/mysql/mysql  ]; then
    echo "MySQL data directory must be empty to restore a backup"
    exit 1
fi

# extract backup file to seperate directory
echo "Restore file found"
mkdir $BASEDIR/data
gzip -d $BASEDIR/backup.stream.gz
mv $BASEDIR/backup.stream $BASEDIR/data
cd $BASEDIR/data
mbstream -x < backup.stream
rm backup.stream
echo "Data extracted from backup"

# prepare backup for restoring
mariabackup --prepare --target-dir=.
echo "Backup Prepared to restore"

# move/restore the data
mariabackup --copy-back --target-dir=.
echo "Copied database files"

echo "Doing cleanup"
# fix file permissions
chown -R 999:999 /var/lib/mysql
# delete any log files that may exist
rm -f /var/lib/mysql/ib_logfile*

echo "Data restored"