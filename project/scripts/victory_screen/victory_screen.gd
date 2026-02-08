extends Node

@export var exit_grabber: MenuOption

func _ready():
	exit_grabber.on_grab.connect(SceneManager.reset_to_main)