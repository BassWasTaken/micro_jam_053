extends CharacterBody2D

@onready var open_hand_sprite = $OpenHand
@onready var closed_hand_sprite = $ClosedHand

@export var SPEED = 300.0
@export var ACCEL = 3000.0

var hovered_tower = null
var is_grabbing_tower = false

func _ready():
	$GrabArea.connect("area_entered", set_hovered_area)
	$GrabArea.connect("area_exited", clear_hovered_area)
	
	GameManager.hand = self

func _physics_process(_delta: float) -> void:
	if is_grabbing_tower:
		return
	var direction_x := Input.get_axis("ui_left", "ui_right")
	var direction_y := Input.get_axis("ui_up", "ui_down")
	var direction = Vector2(direction_x, direction_y).normalized()
	velocity = direction * SPEED

	move_and_slide()

func _process(_delta):
	if is_grabbing_tower and Input.is_action_just_released("ui_accept"):
		is_grabbing_tower = false
	if hovered_tower != null:
		modulate = Color.VIOLET
		if Input.is_action_just_pressed("ui_accept"):
			is_grabbing_tower = true
			# snap to tower
			global_position = hovered_tower.global_position
	else:
		modulate = Color.WHITE
	
	open_hand_sprite.visible = !is_grabbing_tower
	closed_hand_sprite.visible = is_grabbing_tower
	
func set_hovered_area(area):
	hovered_tower = area
	
func clear_hovered_area(_area):
	hovered_tower = null
