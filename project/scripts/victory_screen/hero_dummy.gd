extends Node2D

@export var anim_player: AnimationPlayer

@export var sprite_a: AnimatedSprite2D
@export var sprite_b: AnimatedSprite2D

func _ready():
	var a_active = randi() % 2 == 0
	sprite_a.visible = a_active
	sprite_b.visible = !a_active


func grab():
	anim_player.play("jump")
