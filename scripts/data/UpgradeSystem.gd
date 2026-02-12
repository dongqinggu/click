extends Node

signal upgrade_choices_ready(choices: Array)
signal upgrade_applied(upgrade_id: String)

@export var rooms_per_upgrade := 2
@export var choice_count := 3

var _rooms_cleared := 0
var _upgrades_pool: Array = []
var _rng := RandomNumberGenerator.new()
var _player_stats := {
	"atk_mul": 1.0,
	"aspd_mul": 1.0,
	"crit_add": 0.0,
	"roll_cd_mul": 1.0,
	"on_kill_explode": false,
	"max_hp_mul": 1.0,
}

func _ready() -> void:
	_rng.randomize()
	var data_manager = get_node_or_null("/root/DataManager")
	if data_manager:
		_upgrades_pool = data_manager.get_all_upgrades()

func on_room_cleared() -> void:
	_rooms_cleared += 1
	if _rooms_cleared % rooms_per_upgrade == 0:
		emit_signal("upgrade_choices_ready", _pick_choices())

func apply_upgrade(upgrade: Dictionary) -> void:
	var modifiers: Dictionary = upgrade.get("modifiers", {})
	for key in modifiers.keys():
		if _player_stats.has(key):
			if typeof(_player_stats[key]) == TYPE_BOOL:
				_player_stats[key] = modifiers[key]
			else:
				_player_stats[key] *= modifiers[key]
	emit_signal("upgrade_applied", String(upgrade.get("id", "unknown")))

func get_player_stats() -> Dictionary:
	return _player_stats.duplicate(true)

func _pick_choices() -> Array:
	if _upgrades_pool.is_empty():
		return []
	var pool = _upgrades_pool.duplicate(true)
	pool.shuffle()
	return pool.slice(0, mini(choice_count, pool.size()))
