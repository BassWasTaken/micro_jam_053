extends Node2D
class_name HeroPartyArea

@export var rect: Rect2 = Rect2(0, 0, 750, 250)

@export var rows := 3
@export var hero_scene: PackedScene
@export var hero_count := 0

func _ready():
	hero_count = LevelManager.heroes_remaining
	var per_row: int = hero_count / rows
	var remainder: int = hero_count % rows

	for y in range(rows):
		var w_extra = per_row
		if remainder > 0:
			w_extra += 1
			remainder -= 1

		for x in range(w_extra):
			var hero_prop: Node2D = hero_scene.instantiate()
			add_child(hero_prop)
			hero_prop.position.x = rect.size.x / per_row * x
			hero_prop.position.y = rect.size.y / rows * y


# func _draw():
# 	draw_rect(Rect2(0, 0, width, height), Color.RED)
