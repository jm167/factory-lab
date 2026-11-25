#!/bin/bash
# scripts/format-edited.sh
cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0

FILE=$(node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>console.log(JSON.parse(s).tool_input?.file_path ?? ''))")
[ -z "$FILE" ] && exit 0

if ! pnpm exec prettier --write --ignore-unknown "$FILE" > /dev/null 2> /tmp/format-edited.err; then
  echo "$(date -Is) prettier falló en $FILE: $(head -1 /tmp/format-edited.err)" >> .claude/hooks.log
fi
exit 0