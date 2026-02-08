extends Node

@export var player: AudioStreamPlayer

var current: TwoPartMusic

func _ready():
	player.finished.connect(song_finished)
	Music.on_song_requested.connect(play)

func play(new_song: TwoPartMusic):
	if current == new_song:
		return
	
	current = new_song
	player.stream = new_song.intro
	player.play()

func song_finished():
	if player.stream == current.loop:
		push_warning("loop stopped playing: check if the sample is imported with loop enabled")

	if player.stream == current.intro:
		player.stream = current.loop
		player.play()
