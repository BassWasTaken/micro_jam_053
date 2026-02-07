extends Node

@export var world_node : Node2D

@onready var level_1_button = $LevelManagerUI/BoxContainer/Level1Btn
@onready var level_2_button = $LevelManagerUI/BoxContainer/Level2Btn
@onready var level_3_button = $LevelManagerUI/BoxContainer/Level3Btn

func _ready():
	level_1_button.connect("pressed", func(): start_level("1"))
	level_2_button.connect("pressed", func(): start_level("2"))
	level_3_button.connect("pressed", func(): start_level("3"))
	
	UserInterface.go_to_main_menu_signal.connect(func():
		LevelManager.last_loaded_level.queue_free()
		$LevelManagerUI.visible = true
	)

func start_level(level_id):
	var starting_units = int($LevelManagerUI/StartingUnitsInput.value)
	LevelManager.load_level(world_node, level_id, starting_units)
	$LevelManagerUI.visible = false
