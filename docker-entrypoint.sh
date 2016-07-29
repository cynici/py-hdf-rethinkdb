#! /bin/sh
RUNUSER_UID="${RUNUSER_UID:-1000}"
RUNUSER_HOME="${RUNUSER_HOME:-/home/runuser}"
#set -ux
if [ -x /usr/sbin/useradd ]; then
  useradd -s /bin/false --no-create-home --home-dir "$RUNUSER_HOME" -u $RUNUSER_UID runuser
else
  adduser -s /bin/false -D -h $RUNUSER_HOME -H -u $RUNUSER_UID runuser
fi

# Required by PyHDF
export PYTHON_EGG_CACHE="/tmp/python-eggs"
mkdir $PYTHON_EGG_CACHE
chmod 700 $PYTHON_EGG_CACHE && chown -R runuser.runuser $PYTHON_EGG_CACHE

exec gosu runuser "$@"
