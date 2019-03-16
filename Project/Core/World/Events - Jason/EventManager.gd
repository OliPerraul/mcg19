extends Node

var controlsLocked = false
var interactable
var score = 0 setget update_score
export (NodePath) var camera_path = null
export (NodePath) var player_path = null
export (NodePath) var black_bars = null

var camera
var player

func _ready():
	Globals.events = self
	player = get_node(player_path)
	camera = get_node(camera_path)
	
	player.get_node("area_2D").connect("area_entered", self, "_on_Player_area_entered")
	player.get_node("area_2D").connect("area_exited", self, "_on_Player_area_exited")

func hide_player():
	controlsLocked = true

func unhide_player():
	controlsLocked = false

func camera_cinematic(target_pos, travel_duration, focused_duration, use_black_bars = false):
	player._player_lock()
	$CamTween.interpolate_property(camera, "position", camera.global_position, target_pos, travel_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$CamTween.connect("tween_completed", self, "camera_cinematic_focus", [focused_duration, travel_duration, camera.position])
	if use_black_bars:
		get_node(black_bars).activate_bars()
	$CamTween.start()

func camera_cinematic_focus(object, key, focused_duration, travel_duration, old_position):
	$CamTimer.wait_time = focused_duration
	$CamTween.disconnect("tween_completed", self, "camera_cinematic_focus")
	$CamTimer.connect("timeout", self, "camera_cinematic_return", [travel_duration, old_position])
	$CamTimer.start()

func camera_cinematic_return(travel_duration, target_pos):
	$CamTween.interpolate_property(camera, "position", camera.global_position, target_pos, travel_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$CamTimer.disconnect("timeout", self, "camera_cinematic_return")
	get_node(black_bars).deactivate_bars()
	player._player_unlock()
	if get_node(black_bars).activated:
		get_node(black_bars).deactivate_bars()
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