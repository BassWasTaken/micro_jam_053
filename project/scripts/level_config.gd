extends Node2D


@export var hero_spawners: Array[Node2D]

@export var debug_level := false
@export var debug_count := 20

func _ready():
	if debug_level:
		push_warning("DEBUG LEVEL ON! MAKE SURE ITS DISABLED BEFORE RELEASING")
		distribute(debug_count)
	else:
		distribute(LevelManager.heroes_initial_count)

func distribute(units: int):
	var spawn_count = hero_spawners.size()
	var per_spawn = floori(units / spawn_count)
	var extra = units % spawn_count

	prints(units, spawn_count, per_spawn)
	for s: HeroSpawner in hero_spawners:
		# if !debug_level:
		# 	s.hero_count = 0
		# handle remainders
		if extra > 0:
			extra -= 1
			s.hero_count = per_spawn + 1
			prints("gets", per_spawn + 1)
		else:
			s.hero_count = per_spawn
			prints("gets", per_spawn)
		s.start_spawning()

	# var current_spawner_index = 0
	# while units > 0:
	# 	hero_spawners[current_spawner_index].hero_count += 1
	# 	units -= 1
	# 	current_spawner_index = (current_spawner_index + 1) % hero_spawners.size()
