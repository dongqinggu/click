# Neon Slash (Godot 4, 2D Action Prototype)

面向 **2 个月可上线 Steam 的 2D 动作游戏**起步仓库。该版本重点是把“前期准备 + 可直接开发的骨架 + GitHub 项目管理”一次到位，方便你在 Windows 上直接 checkout 开干。

## 1. 技术栈与目标

- 引擎：Godot 4.2+（Windows 优先）
- 方向：2D 房间制动作（爽快战斗 + 成长）
- 开发方式：数据驱动（`data/*.json`）+ 模块化 GDScript

## 2. 当前仓库已包含

- 项目目录骨架（`scenes/`, `scripts/`, `data/`）
- 战斗/角色/关卡循环核心脚本占位与基础实现
- 敌人与升级初版配置（可直接调数值）
- GitHub Issue 模板 + 2个月里程碑与任务脚本

## 3. Windows 本地快速开始

1. 安装 Godot 4.x（建议 4.2/4.3）。
2. 在本机 clone 本仓库。
3. 用 Godot 打开仓库目录。
4. 运行主场景：`res://scenes/game/Main.tscn`。

> 当前素材使用占位资源（便于先跑通逻辑）。

## 4. 目录结构

```txt
res://
  scenes/
    game/Main.tscn
    game/Room.tscn
    game/HUD.tscn
    game/UpgradePanel.tscn
    player/Player.tscn
    enemies/EnemyBase.tscn
    enemies/Charger.tscn
    enemies/Shooter.tscn
    enemies/Bomber.tscn
    bosses/Boss1.tscn

  scripts/
    core/GameManager.gd
    core/EventBus.gd
    core/TimeController.gd
    combat/Damage.gd
    combat/Hitbox.gd
    combat/Hurtbox.gd
    combat/Health.gd
    combat/Knockback.gd
    data/DataManager.gd
    data/UpgradeSystem.gd
    player/Player.gd
    player/PlayerStateMachine.gd
    enemies/EnemyBase.gd

  data/enemies.json
  data/upgrades.json
```

## 5. GitHub 项目管理（自动化）

仓库中提供了 `scripts/bootstrap_github.sh`：

- 创建 labels
- 创建 milestones
- 批量创建 Issues（P0/P1）

使用前准备：

```bash
gh auth login
export REPO_OWNER="你的 GitHub 用户名"
export REPO_NAME="neon-slash"
./scripts/bootstrap_github.sh
```

## 6. 2个月建议节奏

- Week1：手感原型（移动、普攻、翻滚）
- Week2：战斗闭环（Hitbox/Hurtbox/击退/HitStop）
- Week3-4：成长系统 + 房间流程
- Week5-6：Boss + 打磨（音效、特效、手柄）
- Week7-8：Steam 上线准备（导出、商店素材、测试）
