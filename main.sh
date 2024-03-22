#!/bin/sh
/app/wasmedge/bin/wasmedge --enable-gc \
    --env AUTH_TYPE="$AUTH_TYPE" \
    --env CONTENT_LENGTH="$CONTENT_LENGTH" \
    --env CONTENT_TYPE="$CONTENT_TYPE" \
    --env GATEWAY_INTERFACE="$GATEWAY_INTERFACE" \
    --env PATH_INFO="$PATH_INFO" \
    --env PATH_TRANSLATED="$PATH_TRANSLATED" \
    --env QUERY_STRING="$QUERY_STRING" \
    --env REMOTE_ADDR="$REMOTE_ADDR" \
    --env REMOTE_HOST="$REMOTE_HOST" \
    --env REMOTE_IDENT="$REMOTE_IDENT" \
    --env REMOTE_USER="$REMOTE_USER" \
    --env REQUEST_METHOD="$REQUEST_METHOD" \
    --env SCRIPT_NAME="$SCRIPT_NAME" \
    --env SERVER_NAME="$SERVER_NAME" \
    --env SERVER_PORT="$SERVER_PORT" \
    --env SERVER_PROTOCOL="$SERVER_PROTOCOL" \
    --env SERVER_SOFTWARE="$SERVER_SOFTWARE" \
    --env DOCUMENT_ROOT="$DOCUMENT_ROOT" \
    --env HTTP_COOKIE="$HTTP_COOKIE" \
    --env HTTP_HOST="$HTTP_HOST" \
    --env HTTP_USER_AGENT="$HTTP_USER_AGENT" \
    --env HTTP_REFERER="$HTTP_REFERER" \
    --env REQUEST_URI="$REQUEST_URI" \
    /app/main.wasm | tail -n +2