extends Node2D

func _ready():
	LevelManager.load_level($World, "1", 12)
	UserInterface.go_to_main_menu_signal.connect(func():
		# TODO replace this when the main menu is implemented
		LevelManager.load_level($World, "1", 12)
	)
