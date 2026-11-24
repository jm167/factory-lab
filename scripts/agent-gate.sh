#!/bin/bash
# scripts/agent-gate.sh  (requiere jq)
INPUT=$(cat)
SESSION=$(echo "$INPUT" | jq -r '.session_id')
COUNTER="/tmp/agent-gate-$SESSION"
ATTEMPTS=$(cat "$COUNTER" 2>/dev/null || echo 0)
MAX=3

if pnpm verify > /tmp/verify.log 2>&1; then
  rm -f "$COUNTER"
  exit 0
fi

if [ "$ATTEMPTS" -ge "$MAX" ]; then
  rm -f "$COUNTER"
  exit 0   # Se rinde el gate local; CI sigue bloqueando el merge
fi

echo $((ATTEMPTS + 1)) > "$COUNTER"
tail -50 /tmp/verify.log >&2
echo "verify falló (intento $((ATTEMPTS + 1))/$MAX). Corrige antes de terminar." >&2
exit 2