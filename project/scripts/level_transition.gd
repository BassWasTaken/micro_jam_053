extends Control
class_name LevelTransition

signal faded_out_level

@export var background: ColorRect
@export var anim_player: AnimationPlayer

const FADE_IN := &"fade in"
const FADE_OUT := &"fade out"

func _ready():
	anim_player.animation_finished.connect(_player_finished)

func _player_finished(anim_name: StringName):
	if anim_name == FADE_OUT:
		faded_out_level.emit()

func fade_in_level():
	anim_player.play(FADE_IN, -1.0, 1.0)

func fade_out_level():
	anim_player.play(FADE_OUT, -1.0, 1.0)
