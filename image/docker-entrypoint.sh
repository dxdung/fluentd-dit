#!/bin/bash
set -e

# Add fluentd as command if needed
if [[ "$1" == -* ]]; then
	set -- fluentd "$@"
fi

if [ "$1" = "fluentd" ]; then
  sed -ri "s#<STREAM_NAME>#${STREAM_NAME}#g" /etc/fluent/fluent.conf
  sed -ri "s#<AWS_KEY_ID>#${AWS_KEY_ID}#g" /etc/fluent/fluent.conf
  sed -ri "s#<AWS_SECRET_KEY>#${AWS_SECRET_KEY}#g" /etc/fluent/fluent.conf
  sed -ri "s#<AWS_REGION>#${AWS_REGION:-us-east-1}#g" /etc/fluent/fluent.conf
	set -- "$@"
fi

exec "$@"
