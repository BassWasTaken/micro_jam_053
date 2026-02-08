extends CanvasLayer

@onready var pause_menu = $Base/PauseMenu
@onready var game_over_screen = $Base/GameOverScreen

var paused = false
var is_in_game_over_screen = false

signal go_to_main_menu_signal

# TODO remove spaghetti

func _ready() -> void:
	pause_menu.visible = paused
	pause_menu.on_resume.connect(toggle_pause)
	pause_menu.on_go_to_main_menu.connect(func():
		print("TODO: Go to menu")
		go_to_main_menu_signal.emit()
	)
	game_over_screen.visible = false
	game_over_screen.on_go_to_main_menu.connect(func():
		print("TODO: Go to menu")
		go_to_main_menu_signal.emit()
		is_in_game_over_screen = false
	)

func toggle_pause():
	if is_in_game_over_screen:
		return
	paused = !paused
	pause_menu.visible = paused
	get_tree().paused = paused

func show_game_over_screen():
	is_in_game_over_screen = true
	game_over_screen.visible = true
	pause_menu.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
		
