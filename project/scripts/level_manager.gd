extends Node

var levels_map = {
	"1": {
		"scene": preload("res://project/scenes/levels/level1.tscn"),
		"next": "2"
	},
	"2": {
		"scene": preload("res://project/scenes/levels/level2.tscn"),
		"next": "3"
	},
	"3": {
		"scene": preload("res://project/scenes/levels/level3.tscn"),
		"next": "end"
	},
	"end": {
		"scene": preload("res://project/scenes/testing/level_select.tscn"),
		"next": null
	},
}

var current_level_id : String
var last_loaded_level = null
var heroes_initial_count = 0
var heroes_remaining = 0
var heroes_on_goal = 0

var _heroes_initial_count_for_reset_after_losing = 0

signal distribute_requested(units: int)
signal game_over

func _distribute_units(units, spawners):
	for s in spawners:
		s.hero_count = 0
		s.count_heroes = false
	var current_spawner_index = 0
	while units > 0:
		spawners[current_spawner_index].hero_count += 1
		units -= 1
		current_spawner_index = (current_spawner_index + 1) % spawners.size()


func start_new():
	load_level("1", 16)


func load_level(level_id, starting_units):
	# temp condition to make the level select appear at the end
	if level_id == "end":
		SceneManager.transition_to_scene(levels_map["end"]["scene"])
		# world_node.add_child(levels_map["end"]["scene"].instantiate())
		return


	# var level_config = new_level.find_child("LevelConfig")
	# if level_config:
	# 	_distribute_units(starting_units, level_config.hero_spawners)
	# else:
	# 	push_warning("Unable to find LevelConfig node")

	var new_level = levels_map[level_id]["scene"]
	await get_tree().process_frame

	SceneManager.transition_to_scene(new_level)
	distribute_requested.emit(starting_units)

	current_level_id = level_id
	last_loaded_level = new_level
	heroes_initial_count = starting_units
	heroes_remaining = starting_units
	heroes_on_goal = 0
	if _heroes_initial_count_for_reset_after_losing == 0:
		_heroes_initial_count_for_reset_after_losing = heroes_initial_count

func hero_reached_goal_event():
	if !current_level_id:
		return # load_level was not called, this is a test scene
	heroes_on_goal += 1
	if heroes_on_goal >= heroes_remaining:
		var next_level_id = levels_map[current_level_id]["next"]
		if next_level_id:
			load_level(
				next_level_id,
				heroes_remaining
			)
		else:
			print("no more levels to load")

func hero_died_event():
	if !current_level_id:
		return # load_level was not called, this is a test scene
	heroes_remaining -= 1
	if heroes_remaining <= 0:
		game_over.emit()
