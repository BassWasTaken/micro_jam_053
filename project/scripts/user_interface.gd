extends CanvasLayer

@onready var pause_menu = $Base/PauseMenu
@onready var game_over_screen = $Base/GameOverScreen

var paused = false
var is_in_game_over_screen = false

# TODO remove spaghetti

func _ready() -> void:
	pause_menu.visible = paused
	game_over_screen.visible = false

	LevelManager.game_over.connect(show_game_over_screen)

func toggle_pause():
	if is_in_game_over_screen:
		return
	paused = !paused
	pause_menu.visible = paused
	get_tree().paused = paused

func reset_to_main():
	SceneManager.reset_to_main()
	UserInterface.is_in_game_over_screen = false

	if paused:
		toggle_pause()

	is_in_game_over_screen = false
	game_over_screen.visible = false

func show_game_over_screen():
	is_in_game_over_screen = true
	game_over_screen.visible = true
	pause_menu.visible = false

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		toggle_pause()
