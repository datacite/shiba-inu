#!/bin/sh
if [ "${SERVER_ROLE}" != "secondary" ]; then
  /sbin/setuser app bundle exec rake db:migrate
fi
