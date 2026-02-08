extends Node

@export var start_option: MenuOption
@export var level_start_scene: PackedScene

func _ready():
	start_option.on_grab.connect(start)

func start():
	# TODO: move this config out of here maybe
	LevelManager.start_new()
