#!/bin/sh

if [ -f ~/.flexget/.config-lock ]; then
    rm ~/.flexget/.config-lock
fi

flexget \
    --loglevel "${FLEXGET_LOG_LEVEL:-debug}" \
    daemon start --autoreload-config