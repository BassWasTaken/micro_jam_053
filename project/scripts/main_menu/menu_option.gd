class_name MenuOption
extends Area2D

@export var select_audio: AudioStreamPlayer

signal on_grab()

func grab():
	on_grab.emit()
	select_audio.play()
