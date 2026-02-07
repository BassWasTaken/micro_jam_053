extends Node2D

func _ready():
	$Area2D.connect("body_entered", count_hero)

var total_count = 0
var count = 0

func count_hero(_body):
	count += 1
	$Label.text = str(count) + "/" + str(total_count)
