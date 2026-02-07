extends ColorRect

signal on_go_to_main_menu

func _ready() -> void:
	$Panel/MarginContainer/Buttons/GoToMainMenu.pressed.connect(func():
		on_go_to_main_menu.emit()
	)

func set_message(message):
	$Label.text = message
