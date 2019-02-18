extends Node2D

#Called when node is created
func _ready():
	var prompt = ["Jack", "car", "exiting"]
	var story = "Today %s going to buy a new %s. It is so %s"	
	$Blackboard/Story.bbcode_text = story % prompt
	$Blackboard/TextBox.clear()

#Called when press ENTER on TextBox
func _on_TextBox_text_entered(new_text):
	$Blackboard/Story.bbcode_text = new_text
	$Blackboard/TextBox.clear()

#Called when press TextureButton
func _on_TextureButton_pressed():
	var new_text = $Blackboard/TextBox.get_text()
	_on_TextBox_text_entered(new_text)
