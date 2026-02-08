extends Node

@export var song: TwoPartMusic

func _ready():
	Music.request(song)
