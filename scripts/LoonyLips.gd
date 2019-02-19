extends Node2D

var story = "Today %s going to buy a new %s. It is so %s"	
var prompt = ["a name", "a thing", "a feeling"]
var player_words = []

#Called when node is created
func _ready():
	$Blackboard/StoryText.bbcode_text = "Welcome to Loony Lips!!\n\n"
	$Blackboard/StoryText.bbcode_text += "Can I have " + prompt[player_words.size()] + ", please?"
	$Blackboard/TextBox.clear()

#Called when press ENTER on TextBox
func _on_TextBox_text_entered(new_text):
	player_words.append(new_text);	
	$Blackboard/TextBox.clear()
	check_player_words_length()

#Called when press TextureButton
func _on_TextureButton_pressed():
	var new_text = $Blackboard/TextBox.get_text()
	_on_TextBox_text_entered(new_text)

#Question for the player
func prompt():
	$Blackboard/StoryText.text = "Can I have " + prompt[player_words.size()] + ", please?"

func check_player_words_length():
	if(player_words.size() == prompt.size()):
		tell_story()
		$Blackboard/TextBox.hide()
		$Blackboard/TextureButton.hide()
	else:
		prompt()

#Tell the complete story
func tell_story():
	$Blackboard/StoryText.text = story % player_words

