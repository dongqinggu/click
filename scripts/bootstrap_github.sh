#!/usr/bin/env bash
set -euo pipefail

: "${REPO_OWNER:?Please set REPO_OWNER}"
: "${REPO_NAME:?Please set REPO_NAME}"
REPO="${REPO_OWNER}/${REPO_NAME}"

create_label() {
  local name="$1" color="$2" desc="$3"
  gh label create "$name" --repo "$REPO" --color "$color" --description "$desc" 2>/dev/null || true
}

create_milestone() {
  local title="$1"
  gh api --method POST "repos/$REPO/milestones" -f title="$title" >/dev/null 2>&1 || true
}

create_issue() {
  local title="$1" body="$2" labels="$3" milestone="$4"
  gh issue create --repo "$REPO" --title "$title" --body "$body" --label "$labels" --milestone "$milestone" >/dev/null
}

create_label "priority:P0" "B60205" "Must have"
create_label "priority:P1" "D93F0B" "Should have"
create_label "type:feature" "0052CC" "Feature work"
create_label "type:bug" "D73A4A" "Bug fix"
create_label "area:combat" "5319E7" "Combat system"
create_label "area:progression" "1D76DB" "Progression and upgrades"
create_label "area:steam" "0E8A16" "Steam release"

create_milestone "M1 手感原型 (Week1)"
create_milestone "M2 战斗闭环 (Week2)"
create_milestone "M3 成长系统 (Week4)"
create_milestone "M4 Boss+打磨 (Week6)"
create_milestone "M5 Steam Ready (Week8)"

create_issue "Player movement + roll" "实现基础移动与翻滚无敌帧。" "priority:P0,type:feature,area:combat" "M1 手感原型 (Week1)"
create_issue "3-hit combo + cancel" "实现三段普攻连击与可取消窗口。" "priority:P0,type:feature,area:combat" "M2 战斗闭环 (Week2)"
create_issue "Hitbox/Hurtbox/Health/Knockback" "完成伤害链路闭环。" "priority:P0,type:feature,area:combat" "M2 战斗闭环 (Week2)"
create_issue "Room loop + door" "实现清怪开门与房间推进。" "priority:P0,type:feature,area:progression" "M3 成长系统 (Week4)"
create_issue "Upgrade 3 choices" "每2房间弹出3选1升级。" "priority:P0,type:feature,area:progression" "M3 成长系统 (Week4)"
create_issue "Boss1 implementation" "实现Boss第一版（2技能+二阶段）。" "priority:P0,type:feature,area:combat" "M4 Boss+打磨 (Week6)"
create_issue "Windows export pipeline" "配置导出与发布检查清单。" "priority:P0,type:feature,area:steam" "M5 Steam Ready (Week8)"

echo "GitHub bootstrap completed for $REPO"
