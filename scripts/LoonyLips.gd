extends Node2D

var template = [
		{
			"story" : "Today %s going to buy a new %s. It is so %s",
			"prompt" : ["a name", "a thing", "a feeling"]
		},
		{
			"story" : "A new enemy has arrived to %s. He is the most %s monster in the universe. Use the great %s to defeat him!",
			"prompt" : ["a place", "a adjective", "a object"]
		},
		{
			"story" : "The last %s match in this sesson is %s. I will %s while arrive it.",
			"prompt" : ["a sport", "a time", "a action"]
		}
	]
var current_story
var player_words = []

#Called when node is created
func _ready():
	current_story = get_random_story()
	$Blackboard/StoryText.bbcode_text = "Welcome to Loony Lips!!\n\n"
	$Blackboard/StoryText.bbcode_text += "Can I have " + current_story.prompt[player_words.size()] + ", please?"
	$Blackboard/TextBox.clear()

func get_random_story():
	randomize() #create a new random seed
	var random_number = randi() % template.size()
	return template[random_number]

#Called when press ENTER on TextBox
func _on_TextBox_text_entered(new_text):
	player_words.append(new_text);
	$Blackboard/TextBox.clear()
	check_player_words_length()

#Called when press TextureButton
func _on_TextureButton_pressed():
	if is_story_done():
		if get_tree().reload_current_scene() != 0: #Reload the scene and check if some error happens
			print("ERROR reloading the scene")
	else:
		var new_text = $Blackboard/TextBox.get_text()
		_on_TextBox_text_entered(new_text)

#Question for the player
func prompt():
	$Blackboard/StoryText.text = "Can I have " + current_story.prompt[player_words.size()] + ", please?"

func check_player_words_length():
	if is_story_done():
		tell_story()
	else:
		prompt()

#Check if the story is ready to be told
func is_story_done():
	return player_words.size() == current_story.prompt.size()

#Tell the complete story
func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	end_game()

#Change the elements state
func end_game():
	$Blackboard/TextBox.queue_free()
	$Blackboard/TextureButton/RichTextLabel.text = "Again!"
