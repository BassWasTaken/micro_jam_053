extends Area2D

var speed = 100
var direction = Vector2(1,0)

# Can phase through walls
var has_wall_immunity = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(hit_object)
	# Allow bullet to be inside a wall until is has exited it
	body_exited.connect(func(_body): has_wall_immunity = false)

func _physics_process(delta: float) -> void:
	position += direction * delta * speed

	# TODO kill bullet when out of bounds

func hit_object(body: Node2D):
	if has_wall_immunity:
		return

	if body.has_method("take_damage"):
		body.take_damage(3)
	queue_free()

func grab():
	queue_free()
