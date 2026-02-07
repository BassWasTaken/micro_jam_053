extends CharacterBody2D

@onready var open_hand_sprite = $OpenHand
@onready var closed_hand_sprite = $ClosedHand

@export var SPEED = 300.0
@export var ACCEL = 3000.0

var grabbables: Array[Node] = []
var hovered_tower: Node = null
var is_grabbing_tower = false

func _ready():
	$GrabArea.connect("area_entered", set_hovered_area)
	$GrabArea.connect("area_exited", clear_hovered_area)

	GameManager.hand = self

func _physics_process(_delta: float) -> void:
	if is_grabbing_tower:
		return
	var input_dir = Input.get_vector("left", "right", "up", "down")
	velocity = input_dir.normalized() * SPEED

	move_and_slide()

func _process(_delta):
	if Input.is_action_just_pressed("grab"):
		for grabbable in grabbables:
			grabbable.grab()

	is_grabbing_tower = Input.is_action_pressed("grab")
	modulate = Color.VIOLET if is_grabbing_tower else Color.WHITE

	# # if hovered_tower != null:
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
