extends Area2D

var speed = 100
var direction = Vector2(1,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(hit_object)

func _physics_process(delta: float) -> void:
	position += direction * delta * speed

	# TODO kill bullet when out of bounds

func hit_object(body: Node2D):
	if body.has_method("take_damage"):
		body.take_damage(3)
	queue_free()

func grab():
	print("grab bullet")
	queue_free()
