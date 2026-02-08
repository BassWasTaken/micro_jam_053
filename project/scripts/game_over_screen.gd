extends ColorRect

@export var main_menu_btn: Button
@export var game_over_sfx: AudioStreamPlayer

func _ready() -> void:
	main_menu_btn.pressed.connect(UserInterface.reset_to_main)
	LevelManager.game_over.connect(func(): game_over_sfx.play())

func set_message(message):
	$Label.text = message
