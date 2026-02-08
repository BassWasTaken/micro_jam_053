extends Node2D


@export var hero_spawners: Array[Node2D]
@export var debug_level := false

func _ready():
	distribute(LevelManager.heroes_initial_count)
	if debug_level:
		push_warning("DEBUG LEVEL ON! MAKE SURE ITS DISABLED BEFORE RELEASING")
	# LevelManager.distribute_requested.connect(distribute)

func distribute(units: int):
	for s in hero_spawners:
		if !debug_level:
			s.hero_count = 0
		s.count_heroes = false
	var current_spawner_index = 0
	while units > 0:
		hero_spawners[current_spawner_index].hero_count += 1
		units -= 1
		current_spawner_index = (current_spawner_index + 1) % hero_spawners.size()
