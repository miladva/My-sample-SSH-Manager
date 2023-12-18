#!/bin/bash
if [ -z "$SSH_ORIGINAL_COMMAND" ]; then
    # This is an interactive session
    MAX_SESSIONS=14
    CURRENT_SESSIONS=$(ps aux | grep sshd: | grep -v grep | wc -l)
    if [ "$CURRENT_SESSIONS" -lt "$MAX_SESSIONS" ]; then
        exec /bin/bash
    else
        echo "Maximum number of SSH sessions reached."
        exit 1
    fi
else
    # This is a non-interactive session
    exec $SSH_ORIGINAL_COMMAND
fi
