# #!/bin/sh
if [ "${PUBLIC_KEY}" ]; then
   echo "${PUBLIC_KEY}" > /usr/share/logstash/.ssh/authorized_keys
fi
