extends Node2D

#Called when node is created
func _ready():
	var prompt = ["Jack", "car", "exiting"]
	var story = "Today %s going to buy a new %s. It is so %s"	
	$Blackboard/Story.bbcode_text = story % prompt
	pass