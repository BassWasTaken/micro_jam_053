extends Node

@export var level_transition: LevelTransition
@export var initial_scene: PackedScene
@export var world_root: Node2D

func _ready():
	SceneManager.on_switch.connect(on_scene_load)
	SceneManager.load_scene(initial_scene)

	# LevelManager.load_level($World, "1", 12)
	# UserInterface.go_to_main_menu_signal.connect(func():
	# 	# TODO replace this when the main menu is implemented
	# 	LevelManager.load_level($World, "1", 12)
	# )

func on_scene_load(scene: PackedScene, transition: bool):
	if transition:
		level_transition.fade_out_level()
		await level_transition.faded_out_level

	print("done fadin")
	# clear up old scenes
	for child in world_root.get_children():
		child.queue_free()
	var scene_instance = scene.instantiate()
	world_root.add_child(scene_instance)
	level_transition.fade_in_level();
