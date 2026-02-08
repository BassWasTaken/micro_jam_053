extends Node

signal on_song_requested(song: TwoPartMusic)

func request(song: TwoPartMusic):
	on_song_requested.emit(song)
