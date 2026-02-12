extends Node

var _enemy_config: Dictionary = {}
var _upgrades: Array = []

func _ready() -> void:
	_enemy_config = _load_json_dict("res://data/enemies.json")
	_upgrades = _load_json_array("res://data/upgrades.json")

func get_enemy_config(enemy_type: String) -> Dictionary:
	return _enemy_config.get(enemy_type, {})

func get_all_upgrades() -> Array:
	return _upgrades.duplicate(true)

func _load_json_dict(path: String) -> Dictionary:
	var txt := FileAccess.get_file_as_string(path)
	var parsed = JSON.parse_string(txt)
	if typeof(parsed) != TYPE_DICTIONARY:
		push_error("Invalid dictionary json: %s" % path)
		return {}
	return parsed

func _load_json_array(path: String) -> Array:
	var txt := FileAccess.get_file_as_string(path)
	var parsed = JSON.parse_string(txt)
	if typeof(parsed) != TYPE_ARRAY:
		push_error("Invalid array json: %s" % path)
		return []
	return parsed
