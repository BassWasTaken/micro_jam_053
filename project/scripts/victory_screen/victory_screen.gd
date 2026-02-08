extends Node

@export var exit_grabber: MenuOption
@export var win_sfx: AudioStreamPlayer

func _ready():
	exit_grabber.on_grab.connect(SceneManager.reset_to_main)
	var timer = get_tree().create_timer(0.5)
	timer.timeout.connect(func(): win_sfx.play())
