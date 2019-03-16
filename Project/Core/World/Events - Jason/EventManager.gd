extends Node

var controlsLocked = false

var interactable

signal lock_controls
signal unlock_controls

func hide_player():
	controlsLocked = true
	emit_signal("lock_controls")
	$Dummy.visible = false

func unhide_player():
	controlsLocked = false
	emit_signal("unlock_controls")
	$Dummy.visible = true

func _on_Dummy_area_entered(area):
	interactable = area
	print("entered: ", area.name)


func _on_Dummy_area_exited(area):
	interactable = null
	print("exited: ", area.name)

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if interactable:
			unhide_player() if controlsLocked else hide_player()
