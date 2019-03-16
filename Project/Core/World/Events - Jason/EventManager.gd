extends Node

var controlsLocked = false
var interactable
var score = 0 setget update_score
export (NodePath) var camera = null
export (NodePath) var player = null

signal lock_controls
signal unlock_controls

signal hide_player
signal unhide_player

func _ready():
	get_node(player).get_node("area_2D").connect("area_entered", self, "_on_Player_area_entered")
	get_node(player).get_node("area_2D").connect("area_exited", self, "_on_Player_area_exited")

func hide_player():
	controlsLocked = true
	emit_signal("hide_player")

func unhide_player():
	controlsLocked = false
	emit_signal("unhide_player")

func camera_cinematic(target_pos, travel_duration, focused_duration):
	emit_signal("lock_controls")
	$CamTween.interpolate_property($camera, "position", $camera.position, target_pos, travel_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$CamTween.connect("tween_completed", self, "camera_cinematic_focus", [focused_duration, travel_duration, $camera.position])
	$CamTween.start()

func camera_cinematic_focus(object, key, focused_duration, travel_duration, old_position):
	$CamTimer.wait_time = focused_duration
	$CamTimer.connect("timeout", self, "camera_cinematic_return", [travel_duration, old_position])
	$CamTimer.start()

func camera_cinematic_return(travel_duration, target_pos):
	$CamTween.interpolate_property($camera, "position", $camera.position, target_pos, travel_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$CamTween.connect("tween_completed", self, "emit_signal", ["unlock_controls"])
	$CanvasLayer/BlackBars.deactivate_bars()
	$CamTween.start()

func _on_Player_area_entered(area):
	interactable = area

func _on_Player_area_exited(area):
	interactable = null

func update_score(new_score):
	score = new_score
	
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if interactable:
			unhide_player() if controlsLocked else hide_player()