extends Node

signal on_switch(scene: PackedScene, transition: bool)
signal on_reset_to_main

func load_scene(scene: PackedScene):
	on_switch.emit(scene, false)

func transition_to_scene(scene: PackedScene):
	on_switch.emit(scene, true)

func reset_to_main():
	on_reset_to_main.emit()
