extends Area2D

@export var anim_player: AnimatedSprite2D
@export var nudge_sfx: AudioStreamPlayer

const IDLE = &"idle"
const NUDGE = &"nudge"

func _ready():
	anim_player.play(IDLE)
	anim_player.animation_finished.connect(anim_finished)


func grab():
	anim_player.play(NUDGE)
	nudge_sfx.play()


func anim_finished():
	if anim_player.animation == NUDGE:
		anim_player.play(IDLE)
