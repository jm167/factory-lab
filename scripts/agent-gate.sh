#!/bin/bash
# scripts/agent-gate.sh
INPUT=$(cat)

field() {
  echo "$INPUT" | node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>{const v=JSON.parse(s)[process.argv[1]];console.log(v ?? '')})" "$1"
}

SESSION=$(field session_id)
if [ -z "$SESSION" ]; then
  echo "agent-gate: no pude leer session_id del input del hook" >&2
  exit 1
fi

COUNTER="/tmp/agent-gate-$SESSION"
LOG="/tmp/verify-$SESSION.log"
ATTEMPTS=$(cat "$COUNTER" 2>/dev/null || echo 0)
MAX=3

# El agente pide intervención humana: se deja terminar sin correr verify
LAST=$(field last_assistant_message)
if echo "$LAST" | grep -q '\[NEEDS-USER\]'; then
  echo "$(date -Is) $SESSION escalated" >> "${CLAUDE_PROJECT_DIR:-.}/.claude/escalations.log"
  rm -f "$COUNTER"
  exit 0
fi

if pnpm verify > "$LOG" 2>&1; then
  rm -f "$COUNTER" "$LOG"
  exit 0
fi

if [ "$ATTEMPTS" -ge "$MAX" ]; then
  rm -f "$COUNTER" "$LOG"
  exit 0   # Se rinde el gate local; CI sigue bloqueando el merge
fi

echo $((ATTEMPTS + 1)) > "$COUNTER"
tail -50 "$LOG" >&2
echo "verify falló (intento $((ATTEMPTS + 1))/$MAX). Corrige antes de terminar." >&2
exit 2