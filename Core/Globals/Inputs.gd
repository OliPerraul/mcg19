extends Node


func mouse_check(event, button):
	if event is InputEventMouseButton:
		if event.button_index == button and not event.is_pressed():
			return true
			INF
	return false
	
	
func mouse_released(event, button):
	if event is InputEventMouseButton:
		if event.button_index == button and not event.is_pressed():
			return true
			
	return false



