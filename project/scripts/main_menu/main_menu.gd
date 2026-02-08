extends Node

@export var start_option: MenuOption
@export var level_transition: LevelTransition

func _ready():
	start_option.on_grab.connect(start)

func start():
	pass
