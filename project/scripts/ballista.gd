extends Area2D

@export var bullet_direction = Vector2(0,1)
@export var disable_timer: Timer
@export var tower_visual: Polygon2D
@export var bullet_scene: PackedScene

var timer = Timer.new()

var disabled = false

func _ready() -> void:
	add_child(timer)
	timer.wait_time = 1
	timer.start()
	timer.connect("timeout", shoot)

	# reenable timer if timer expires
	disable_timer.timeout.connect(enable)

func _process(_delta: float) -> void:
	pass

func shoot():
	if disabled:
		return
	# if GameManager.hand \
	# and GameManager.hand.hovered_tower == self \
	# and GameManager.hand.is_grabbing_tower:
	# 	return # dont shoot if tower is being grabbed

	var b = bullet_scene.instantiate()
	b.global_position = global_position
	b.direction = bullet_direction
	get_parent().add_child(b)

func grab():
	disable()

func enable():
	disabled = false
	tower_visual.modulate = Color.WHITE

func disable():
	disabled = true
	disable_timer.start()
	tower_visual.modulate = Color.DARK_GRAY
