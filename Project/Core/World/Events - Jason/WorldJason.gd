extends Node2D

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_SPACE:
		if $EventManager/CanvasLayer/BlackBars.activated:
			$EventManager/CanvasLayer/BlackBars.deactivate_bars()
		else:
			$EventManager/CanvasLayer/BlackBars.activate_bars()
	elif event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$EventManager.score += max($EventManager.score, 1)