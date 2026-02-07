extends CharacterBody2D

@onready var open_hand_sprite = $OpenHand
@onready var closed_hand_sprite = $ClosedHand

@export var speed = 300.0
@export var accel = 3000.0

@export var dash_speed = 900.0
@export var dash_seconds = 1.0
@export var dash_curve: Curve
@export var dash_sound: AudioStreamPlayer
var dash_progress := 0.0

var grabbables: Array[Node] = []
var hovered_tower: Node = null
var is_grabbing_tower = false

func _ready():
	$GrabArea.connect("area_entered", set_hovered_area)
	$GrabArea.connect("area_exited", clear_hovered_area)

	GameManager.hand = self

func _physics_process(delta: float) -> void:
	if is_grabbing_tower:
		# Cancel dash if player is locked
		dash_progress = 0.0
		return
	var input_dir = Input.get_vector("left", "right", "up", "down")

	# Cancel dash if theres no remaining velocity
	if input_dir.length_squared() < 0.001:
		dash_progress = 0.0

	var current_speed = speed

	if dash_progress > 0.0:
		var weight = dash_curve.sample_baked(dash_progress)
		current_speed = lerp(dash_speed, speed, weight)
		dash_progress -= dash_seconds * delta

	velocity = input_dir * current_speed

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("grab"):
		for grabbable in grabbables:
			grabbable.grab()

	if Input.is_action_just_pressed("dash") && dash_progress <= 0.0:
		dash_sound.play()
		dash_progress = dash_seconds

	is_grabbing_tower = Input.is_action_pressed("grab")
	modulate = Color.VIOLET if is_grabbing_tower else Color.WHITE

	# # if hovered_tower != null:DW
	# # 	modulate = Color.VIOLET
	# # 	if Input.is_action_just_pressed("ui_accept"):
	# # 		is_grabbing_tower = true
	# # 		# snap to tower
	# # 		global_position = hovered_tower.global_position
	# else:
	# 	modulate = Color.WHITE

	open_hand_sprite.visible = !is_grabbing_tower
	closed_hand_sprite.visible = is_grabbing_tower

func set_hovered_area(area):
	if area.has_method("grab"):
		grabbables.push_back(area)

func clear_hovered_area(area):
	grabbables.erase(area)
