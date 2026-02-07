extends Label

func _process(_delta):
	text = "Alive: " + str(LevelManager.heroes_remaining)
