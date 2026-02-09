extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@onready var hp_bar = $HpBar
@onready var sound = $AudioStreamPlayer2D
@onready var hitbox = $Hitbox
@onready var animation_player = $AnimationPlayer

@export var hit_sounds: Array[AudioStream]
@export var die_sounds: Array[AudioStream]
@export var speed = 50

var boost_time = 0
var boost_delay = 0

var max_hp = 10.0
var hp = max_hp

var active = false

func _ready():
	if randi_range(0,1) == 0:
		$AnimHolder/Anim1.visible = true
		$AnimHolder/Anim2.visible = false
	else:
		$AnimHolder/Anim1.visible = false
		$AnimHolder/Anim2.visible = true
	$GrabArea.on_grab.connect(trigger_boost)

func navigate_to_goal(goal_position):
	active = true
	navigation_agent.target_position = goal_position

func _physics_process(delta: float) -> void:
	if active:
		var next_path_pos = navigation_agent.get_next_path_position()
		var direction = global_position.direction_to(next_path_pos)
		var test_boost = 10 if Input.is_key_pressed(KEY_T) else 1
		var boost_multiplier = 1
		if boost_time > 0:
			boost_time -= delta
			boost_multiplier = 3
		if boost_delay > 0:
			boost_delay -= delta
			# dont move for an instant while jumping after grab
			boost_multiplier = 0
		velocity = direction * speed * boost_multiplier * test_boost
		move_and_slide()

func take_damage(amount):
	hp -= amount
	hp_bar.value = hp / max_hp * hp_bar.max_value
	if hp <= 0:
		die()
	else:
		sound.stop()
		sound.stream=hit_sounds.pick_random()
		sound.play()

func die():
	sound.stop()
	sound.stream=die_sounds.pick_random()
	sound.play()
	hitbox.set_deferred("disabled",true)
	visible = false
	active = false
	LevelManager.hero_died_event()
	await sound.finished 
	queue_free()

func trigger_boost():
	animation_player.play("jumpy")
	boost_delay = 0.1
	boost_time = 1.5
