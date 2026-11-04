#!/bin/bash
# PreToolUse hook (Bash): allow `git push` only to the user's personal GitHub namespace.
# Blocks pushes to any other remote (e.g. your company organisation), even when the
# command was typed by the user. Fails closed when the remote cannot be resolved.
ALLOWED_OWNER="<github-user>"   # set to your GitHub username
input="$(cat)"
cmd="$(printf '%s' "$input" | jq -r '.tool_input.command // empty')"
cwd="$(printf '%s' "$input" | jq -r '.cwd // empty')"

# Only act on commands that contain a git push (also covers `gh repo create ... --push`? no: gh handles its own push)
printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+push([[:space:]]|$)' || exit 0

deny() {
  jq -n --arg r "$1" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'
  exit 0
}

# Repo directory: `git -C <dir>` wins, then a leading `cd <dir> &&`, then the hook cwd
dir="$(printf '%s' "$cmd" | sed -nE 's/.*git[[:space:]]+-C[[:space:]]+("([^"]+)"|'"'"'([^'"'"']+)'"'"'|([^[:space:]]+)).*/\2\3\4/p' | head -1)"
if [ -z "$dir" ]; then
  dir="$(printf '%s' "$cmd" | sed -nE 's/^[[:space:]]*cd[[:space:]]+("([^"]+)"|'"'"'([^'"'"']+)'"'"'|([^[:space:];&|]+)).*/\2\3\4/p' | head -1)"
fi
[ -z "$dir" ] && dir="$cwd"
dir="${dir/#\~/$HOME}"

# Remote: first non-option token after `push`, default origin
# Cut the command at the first shell operator after push, drop options and redirections
remote="$(printf '%s' "$cmd" | sed -nE 's/.*git([[:space:]]+-C[[:space:]]+[^[:space:]]+)?[[:space:]]+push[[:space:]]+(.*)$/\2/p' | sed -E 's/[;&|].*$//' | tr ' ' '\n' | grep -v '^-' | grep -Ev '^[0-9]*>' | grep -Ev '^[0-9]*<' | grep -v '^$' | head -1)"
[ -z "$remote" ] && remote="origin"

case "$remote" in
  http://*|https://*|git@*|ssh://*) url="$remote" ;;
  *) url="$(git -C "$dir" remote get-url "$remote" 2>/dev/null)" ;;
esac

[ -z "$url" ] && deny "git push blocked: cannot resolve remote '$remote' in '$dir'. Only pushes to github.com/$ALLOWED_OWNER/ are allowed."

if printf '%s' "$url" | grep -Eiq "github\.com[/:]${ALLOWED_OWNER}/"; then
  exit 0
fi
deny "git push blocked: remote '$remote' points to '$url'. Only the personal namespace github.com/$ALLOWED_OWNER/ is allowed (hook ~/.claude/hooks/guard-git-push.sh)."
