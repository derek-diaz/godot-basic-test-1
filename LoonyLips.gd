extends Control

var prompts = ["Name", "Movie"]
var player_words = []
var story = "Once upon a time %s watched %s amd thought it was the greatest movie"

onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText
onready var DisplayText = $VBoxContainer/DisplayText
onready var Label = $VBoxContainer/HBoxContainer/Label

func _ready():
	Label.text = "ok"
	PlayerText.grab_focus()
	DisplayText.text = "Welcome!"
	check_player_words_length()


func _on_PlayerText_text_entered(new_text):
	add_to_player_words()

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

func add_to_player_words():
	player_words.append(PlayerText.text)
	DisplayText.text = ""
	PlayerText.clear()
	check_player_words_length()
	
func is_story_done():
	return player_words.size() == prompts.size()
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = story % player_words
	pass
	
func prompt_player():
	DisplayText.text += "May I have " + prompts[player_words.size()] + " please?"
	pass
	
func end_game():
	PlayerText.queue_free()
	Label.text = "Try Again?"
	tell_story()
