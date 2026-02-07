extends Node2D

func _ready():
	$Area2D.connect("body_entered", count_hero)
	await get_tree().create_timer(0.1).timeout
	update_label()

func count_hero(_body):
	LevelManager.hero_reached_goal_event()
	update_label()

func update_label():
	$Label.text = str(LevelManager.heroes_on_goal) + "/" + str(LevelManager.heroes_initial_count)
