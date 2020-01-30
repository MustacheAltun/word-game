extends Control

var player_words = []
#var template = [
#	{
#	"info" : ["vaardigheid", "voorwerp", "extra voorwerp",  "nummer"],
#	"story" : "ik ben goed met %s, maar het ligt allemaal aan de %s en niet aan de %s met de nummer %s"
#	},
#	{
#	"info" : ["voorwerp dat je kan voelen", "voorwerp dat je kan voelen", "vorm van neerslag",  "vorm van neerslag"],
#	"story" : "Het leven draait om een %s, maar toch vind ik dat het om een %s draait. Daarnaast doucte in %s en in %s"
#	},
#	{
#	"info" : ["dier", "dier", "smaak",  "vorm van wel of niet"],
#	"story" : "ik ben slimmer dan een %s, maar toch dommer dan een %s is. ik vind vis %s en patat %s"
#	},
#	{
#	"info" : ["persoon/personen", "insect", "extra insect",  "materiaal of grond"],
#	"story" : "“Dus wat vinden %s nou van zo’n zonnetje?”, waarop de %s zijn schouders ophaalde en zowel hij als de %s weer de %s in trokken."
#	},
#	{
#	"info" : ["lichaamsdeel", "eigenschap van geluid", "werkwoord"],
#	"story" : "als je %s slaapt, kun je geen %s meer %s"
#	},
#	{
#	"info" : ["nummer", "dier"],
#	"story" : "beter %s %s in de hand dan geen hand"
#	},
#	{
#	"info" : ["persoon/personen", "persoon/personen"],
#	"story" : "beter een scheet voor %s, dan buikpijn voor jou %s"
#	},
#	{
#	"info" : ["eigenschap van de wereld", "extra voorwerp"],
#	"story" : "De %s tijd van het leven wordt met %s verprutst"
#	},
#	]
var current_story = {}

onready var DisplayText = $DisplayText
onready var PlayerInput = $VBoxContainer/HBoxContainer/PlayerInput
onready var Labels = $VBoxContainer/HBoxContainer/TextureButton/Label
onready var storybook = $StoryBook

func _ready():
	set_current_story()
	DisplayText.text = "welkom in een leuke woord spelletje, we gaan je een verhaal vertellen een leuke tijd bij elkaar hebben.\n"
	check_player_words_length()
	PlayerInput.grab_focus()

func set_current_story():
	randomize()
	var stories = storybook.get_child_count()
	var selected_story = randi() % stories
	current_story.info = storybook.get_child(selected_story).info
	current_story.story = storybook.get_child(selected_story).story
#	current_story = template [randi() % template.size()]

func _on_PlayerInput_text_entered(new_text):
	add_to_player_words()

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		add_to_player_words()

func add_to_player_words():
	player_words.append(PlayerInput.text)
	DisplayText.text = ""
	PlayerInput.clear()
	check_player_words_length()

func is_story_done():
	return player_words.size() == current_story.info.size()
	#if you wanna return something use return, return is if you want to get information back which is changeable instead of print
	
func check_player_words_length():
	if is_story_done():
		end_game()
	else:
		prompt_player()

func tell_story():
	DisplayText.text = current_story.story % player_words

func prompt_player():
	DisplayText.text += "mag ik een " +current_story.info [player_words.size()]+ " alsjeblieft?"

func end_game():
	PlayerInput.queue_free()
	Labels.text = "again!"
	tell_story()