extends Node2D

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$EventManager.score += max($EventManager.score, 1)

func _on_EventManager_hide_player():
	$Player._on_EventManager_lock_controls()
	$EventManager/CanvasLayer/BlackBars.activate_bars()
	$Player/Sprite.visible = false


func _on_EventManager_unhide_player():
	$Player._on_EventManager_unlock_controls()
	$EventManager/CanvasLayer/BlackBars.deactivate_bars()
	$Player/Sprite.visible = true
