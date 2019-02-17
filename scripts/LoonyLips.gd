extends Node2D

func _ready():
	var person = "Jack"
	var thing = "car"
	var feeling = "exciting"
	var story = "Today " + person + " going to buy a new " + thing +". It is so " + feeling
	print(story)
	pass