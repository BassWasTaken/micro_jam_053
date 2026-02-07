extends CanvasLayer

@onready var pause_menu = $Base/PauseMenu

var paused = false

signal go_to_main_menu_signal

func _ready() -> void:
	pause_menu.visible = paused
	pause_menu.on_resume.connect(toggle_pause)
	pause_menu.on_go_to_main_menu.connect(func():
		print("TODO: Go to menu")
		go_to_main_menu_signal.emit()
	)

func toggle_pause():
	paused = !paused
	pause_menu.visible = paused
	get_tree().paused = paused

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
		
