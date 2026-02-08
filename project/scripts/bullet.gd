extends Area2D

@export_flags_2d_physics var wall_mask := 0


@onready var sprite = $Sprite
@onready var audio = $AudioStreamPlayer2D
@onready var hitbox = $Hitbox

@export var impact_sounds: Array[AudioStream]

var speed = 100
var direction = Vector2(1,0)

# Can phase through walls
var has_wall_immunity = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(hit_object)
	# Allow bullet to be inside a wall until is has exited it
	body_exited.connect(func(_body): has_wall_immunity = false)
	sprite.look_at(sprite.global_position + direction)

func _physics_process(delta: float) -> void:
	position += direction * delta * speed

	# TODO kill bullet when out of bounds

func hit_object(body: Node2D):
	if body is TileMapLayer and has_wall_immunity:
		return
	

	if body.has_method("take_damage"):
		body.take_damage(3)
		audio.stream = impact_sounds.pick_random()
		audio.play()
		
	remove()

func grab():
	remove()
	
func remove():
	hitbox.set_deferred("disabled",true)
	sprite.visible = false
	if audio.playing:
		await audio.finished
	queue_free()
	
