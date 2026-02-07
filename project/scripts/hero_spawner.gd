extends Node2D

@export var hero_goal : Node2D
@export var hero_count = 4
@export var initial_delay = 0.5
@export var spawn_interval = 3
@export var count_heroes = false

var Hero = preload("res://project/scenes/hero.tscn")

var timer = Timer.new()

func _ready() -> void:
	if count_heroes:
		hero_goal.total_count += hero_count
	add_child(timer)
	timer.wait_time = 3
	await get_tree().create_timer(initial_delay).timeout
	spawn_hero()
	timer.start()
	timer.connect("timeout", spawn_hero)

func spawn_hero():
	var h = Hero.instantiate()
	get_tree().root.add_child(h) # TODO confirm hero parent is ok
	h.global_position = global_position
	h.navigate_to_goal(hero_goal.global_position)
	hero_count -= 1
	if hero_count == 0:
		queue_free()
