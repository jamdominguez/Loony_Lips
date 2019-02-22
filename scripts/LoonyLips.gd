extends Node2D

var current_story
var player_words = []
var STRINGS #location STRINGS (constants)

#Called when node is created
func _ready():
	current_story = get_random_story()
	STRINGS = get_from_json("./other_STRINGS.json")
	$Blackboard/StoryText.bbcode_text = STRINGS.welcome
	$Blackboard/StoryText.bbcode_text += STRINGS.question % current_story.prompt[player_words.size()]
	$Blackboard/TextBox.clear()

#Return a ramdon story
func get_random_story():
	var stories = get_from_json("./stories.json")
	randomize() #create a new random seed
	var random_number = randi() % stories.size()
	return stories[random_number]

#Get the filename content like json object
func get_from_json(filename):
	var file = File.new()
	var data = []
	var result = file.open(filename, File.READ)
	if result != 0:
		print(STRINGS.error_open_file % filename)
	else:
		var text = file.get_as_text()
		data = parse_json(text)
		file.close()	
	return data

#Called when press ENTER on TextBox
func _on_TextBox_text_entered(new_text):
	player_words.append(new_text);
	$Blackboard/TextBox.clear()
	check_player_words_length()

#Called when press TextureButton
func _on_TextureButton_pressed():
	if is_story_done():
		if get_tree().reload_current_scene() != 0: #Reload the scene and check if some error happens
			print(STRINGS.error_reload_scene)
	else:
		var new_text = $Blackboard/TextBox.get_text()
		_on_TextBox_text_entered(new_text)

#Question for the player
func prompt():
	$Blackboard/StoryText.text = STRINGS.question % current_story.prompt[player_words.size()]

#Execute a action acording the size of player words
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
	$Blackboard/TextureButton/RichTextLabel.text = STRINGS.again
