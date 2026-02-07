extends Node

@export var start_option: MenuOption

func _ready():
	start_option.on_grab.connect(start)

func start():
	print("start")
