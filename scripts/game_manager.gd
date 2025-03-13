extends Node
@onready var label: Label = $Label

var points = 0

func add_point():
	print("add coin")
	points += 1
	label.text = "You have collected " + str(points)
