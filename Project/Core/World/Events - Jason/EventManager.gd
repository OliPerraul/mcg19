extends Node

var controlsLocked = false
var interactable
var score = 0 setget update_score

signal lock_controls
signal unlock_controls

func hide_player():
	controlsLocked = true
	emit_signal("lock_controls")
	$PLayer.visible = false

func unhide_player():
	controlsLocked = false
	emit_signal("unlock_controls")
	$PLayer.visible = true

func camera_cinematic(target_pos, travel_duration, focused_duration):
	emit_signal("lock_controls")
	var cam = $PLayer/Camera2D
	var cam_pos = $PLayer/Camera2D.position
	$CamTween.interpolate_property(cam, "position", cam_pos, target_pos, travel_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$CamTween.connect("tween_completed", self, "camera_cinematic_focus", [focused_duration, travel_duration, cam_pos])
	$CamTween.start()

func camera_cinematic_focus(object, key, focused_duration, travel_duration, old_position):
	$CamTimer.wait_time = focused_duration
	$CamTimer.connect("timeout", self, "camera_cinematic_return", [travel_duration, old_position])
	$CamTimer.start()

func camera_cinematic_return(travel_duration, target_pos):
	$CamTween.interpolate_property($PLayer/Camera2D, "position", $PLayer/Camera2D.position, target_pos, travel_duration, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$CamTween.connect("tween_completed", self, "emit_signal", ["unlock_controls"])
	$CanvasLayer/BlackBars.deactivate_bars()
	$CamTween.start()

func _on_Dummy_area_entered(area):
	interactable = area
	print("entered: ", area.name)

func _on_Dummy_area_exited(area):
	interactable = null
	print("exited: ", area.name)

func update_score(new_score):
	score = new_score
	print("boop")
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		$CanvasLayer/BlackBars.deactivate_bars() if $CanvasLayer/BlackBars.activated else $CanvasLayer/BlackBars.activate_bars()
		camera_cinematic($Truck.position, 1, 3)
		update_score(score + max(score, 1))
		print(score)
		if interactable:
			unhide_player() if controlsLocked else hide_player()
