extends ColorRect

signal on_resume
signal on_go_to_main_menu

func _ready() -> void:
	$Panel/MarginContainer/Buttons/Resume.pressed.connect(func():
		on_resume.emit()
	)
	$Panel/MarginContainer/Buttons/GoToMainMenu.pressed.connect(func():
		on_go_to_main_menu.emit()
	)
