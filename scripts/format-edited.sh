#!/bin/bash
# scripts/format-edited.sh
FILE=$(node -e "let s='';process.stdin.on('data',d=>s+=d).on('end',()=>console.log(JSON.parse(s).tool_input?.file_path ?? ''))")
[ -n "$FILE" ] && pnpm exec prettier --write --ignore-unknown "$FILE" > /dev/null 2>&1
exit 0