extends Node

func play(sound: AudioStream, volume := 1.0):
	var tmp_player = AudioStreamPlayer.new()
	tmp_player.finished.connect(func(): tmp_player.queue_free())
	tmp_player.volume_db = volume
	tmp_player.bus = &"Sfx"
	get_tree().root.add_child(tmp_player)
	tmp_player.stream = sound
	tmp_player.play()