extends Node2D

#Called when node is created
func _ready():
	var prompt = ["Jack", "car", "exicting"]
	var story = "Today %s going to buy a new %s. It is so %s"
	print(story % prompt)
	pass