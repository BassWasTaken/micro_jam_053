extends Node2D

@export var hero_goal : Node2D
@export var hero_count = 4
@export var initial_delay = 0.5
@export var spawn_interval = 3
@export var count_heroes = false

var Hero = preload("res://project/scenes/hero.tscn")

var timer_initial = Timer.new()
var timer = Timer.new()

func _ready() -> void:
	if hero_count == 0:
		return
	if count_heroes:
		LevelManager.heroes_remaining += hero_count
	
	add_child(timer_initial)
	timer_initial.start(initial_delay)
	timer_initial.connect("timeout", initial_spawn)
	timer_initial.one_shot = true

func initial_spawn():
	spawn_hero()
	add_child(timer)
	timer.start(spawn_interval)
	timer.connect("timeout", spawn_hero)

func spawn_hero():
	var h = Hero.instantiate()
	get_parent().add_child(h)
	h.global_position = global_position
	h.navigate_to_goal(hero_goal.global_position)
	hero_count -= 1
	if hero_count == 0:
		queue_free()
