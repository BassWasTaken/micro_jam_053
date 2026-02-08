extends Area2D

@export var bullet_direction = Vector2(0,1)
@export var disable_timer: Timer
@export var tower_visual: Polygon2D
@export var bullet_scene: PackedScene
@onready var audio = $AudioStreamPlayer

@export var fire_sounds: Array[AudioStream]
@export var disable_sound: AudioStream

@onready var seal = $Seal

var timer = Timer.new()

var disabled = false

func _ready() -> void:
	seal.visible = false
	add_child(timer)
	timer.wait_time = 1
	timer.start()
	timer.connect("timeout", shoot)

	# reenable timer if timer expires
	disable_timer.timeout.connect(enable)

func _process(delta: float) -> void:
	$Seal.rotation_degrees += delta * 60

func shoot():
	if disabled:
		return
	# if GameManager.hand \
	# and GameManager.hand.hovered_tower == self \
	# and GameManager.hand.is_grabbing_tower:
	# 	return # dont shoot if tower is being grabbed

	audio.stream = fire_sounds.pick_random()
	
	var b = bullet_scene.instantiate()
	b.global_position = global_position
	b.direction = bullet_direction
	get_parent().add_child(b)

func grab():
	disable()

func enable():
	disabled = false
	tower_visual.modulate = Color.WHITE
	seal.visible = false

func disable():
	if !disabled:
		audio.stream = disable_sound
		audio.play()

	disabled = true
	disable_timer.start()
	tower_visual.modulate = Color.DARK_GRAY
	seal.visible = true
