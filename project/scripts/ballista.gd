extends Area2D

@export var bullet_direction = Vector2(0,1)

var Bullet = preload("res://project/scenes/bullet.tscn")

var timer = Timer.new()

var is_grabbed = false

func _ready() -> void:
	add_child(timer)
	timer.wait_time = 1
	timer.start()
	timer.connect("timeout", shoot)

func _process(_delta: float) -> void:
	pass

func shoot():
	if GameManager.hand \
	and GameManager.hand.hovered_tower == self \
	and GameManager.hand.is_grabbing_tower:
		return # dont shoot if tower is being grabbed

	var b = Bullet.instantiate()
	b.global_position = global_position
	b.direction = bullet_direction
	get_tree().root.add_child(b) # TODO confirm bullet parent is ok
