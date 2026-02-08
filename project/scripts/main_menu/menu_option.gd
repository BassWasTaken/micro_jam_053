class_name MenuOption
extends Area2D

@export var select_audio: AudioStreamPlayer
@export var label: Control

signal on_grab()

func _ready():
	body_entered.connect(hover_start)
	body_exited.connect(hover_end)

func grab():
	on_grab.emit()
	select_audio.play()

func hover_start(body: Node2D):
	if body.name.to_lower().contains("hand"):
		label.modulate = Color.MAGENTA

func hover_end(body: Node2D):
	if body.name.to_lower().contains("hand"):
		label.modulate = Color.WHITE