#!/usr/bin/env bash
# 現在のブランチを push し、「自分の fork の main」宛に PR を作る。
# base を自分の fork に固定するので、講座 repo (matsuolab) に誤って出さずに済む。
#
# 使い方:  bash scripts/submit_pr.sh "第1回 演習"
set -euo pipefail

title="${1:?使い方: bash scripts/submit_pr.sh \"PRのタイトル\"}"
branch="$(git branch --show-current)"
[ "$branch" != "main" ] || { echo "main では実行できません。lecNN ブランチに切り替えてください。" >&2; exit 1; }

# origin（= 自分の fork）の owner/repo を取得
repo="$(git remote get-url origin | sed -E 's#(git@github.com:|https://github.com/)##; s#\.git$##')"
owner="${repo%%/*}"
case "$owner" in matsuolab) echo "origin が講座 repo です。自分の fork を origin にしてください。" >&2; exit 1;; esac

git push -u origin "$branch"
gh pr create --repo "$repo" --base main --head "$owner:$branch" --title "$title" --body "提出: $branch"
echo "base/head とも $repo であることを確認してください。"
