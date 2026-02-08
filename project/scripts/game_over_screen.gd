extends ColorRect

@export var main_menu_btn: Button

func _ready() -> void:
	main_menu_btn.pressed.connect(UserInterface.reset_to_main)

func set_message(message):
	$Label.text = message
