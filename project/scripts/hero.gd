extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@onready var hp_bar = $HpBar

@export var speed = 50

var max_hp = 10.0
var hp = max_hp

var active = false

func navigate_to_goal(goal_position):
	active = true
	navigation_agent.target_position = goal_position

func _physics_process(_delta: float) -> void:
	if active:
		var next_path_pos = navigation_agent.get_next_path_position()
		var direction = global_position.direction_to(next_path_pos)
		var boost = 10 if Input.is_key_pressed(KEY_T) else 1
		velocity = direction * speed * boost
		move_and_slide()

func take_damage(amount):
	hp -= amount
	hp_bar.value = hp / max_hp * hp_bar.max_value
	if hp <= 0:
		die()

func die():
	LevelManager.hero_died_event()
	queue_free()
