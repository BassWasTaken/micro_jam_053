extends Node

@export var player: AudioStreamPlayer
@export var low_intensity: TwoPartMusic
@export var mid_intensity: TwoPartMusic

var current: TwoPartMusic

func _ready():
	player.finished.connect(song_finished)
	play(low_intensity)

func _process(_delta):
	if Input.is_key_pressed(KEY_N):
		play(mid_intensity)

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
