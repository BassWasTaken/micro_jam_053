extends Control

@export var world_node : Node2D

@onready var level_1_button = $BoxContainer/Level1Btn
@onready var level_2_button = $BoxContainer/Level2Btn
@onready var level_3_button = $BoxContainer/Level3Btn

func _ready():
	level_1_button.connect("pressed", func(): start_level("1"))
	level_2_button.connect("pressed", func(): start_level("2"))
	level_3_button.connect("pressed", func(): start_level("3"))

func start_level(level_id):
	var starting_units = int($StartingUnitsInput.value)
	LevelManager.load_level(world_node, level_id, starting_units)
	visible = false
