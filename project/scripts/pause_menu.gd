extends ColorRect

@export var pause_btn: Button
@export var main_menu_btn: Button

func _ready() -> void:
	pause_btn.pressed.connect(UserInterface.toggle_pause)
	main_menu_btn.pressed.connect(UserInterface.reset_to_main)
