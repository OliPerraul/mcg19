extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _ready():
	$"../Score".set_text("SCORE: "+String(Globals.score))
	$"../HighScore".set_text("HIGH SCORE: "+String(Globals.high_score))
	print("boop")

# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed('click') || event.is_action_pressed('ui_accept'):
		get_tree().change_scene("res://Core/Start/StartScreen.tscn")
