extends Node

signal on_switch(scene: PackedScene, transition: bool)

func load_scene(scene: PackedScene):
	on_switch.emit(scene, false)

func transition_to_scene(scene: PackedScene):
	on_switch.emit(scene, true)
