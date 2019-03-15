extends 'Controller.gd'



func _process(delta):
	if active :			
		
		# Lerp towards target axis values	
		
		horizontal = lerp(horizontal, _target_horizontal, _AXIS_LERP_AMOUNT)
		horizontal = Floats.approximate(horizontal)
		
		vertical = lerp(vertical, _target_vertical, _AXIS_LERP_AMOUNT)
		vertical = Floats.approximate(vertical)
		
		
		# Jump	
#		if Input.is_action_just_pressed("ui_select"):
#			jump_pressed = true
#		else:
#			jump_pressed = false
#
#		if Input.is_action_pressed("ui_select"):
#			jump_checked = true
#		else:
#			jump_checked = false


func set_target_horizontal(weight):
	pass

func set_target_vertical(weight):
	pass


func deactivate():
	jump_pressed = false
	jump_checked = false
	horizontal = 0
	vertical = 0
	_target_horizontal = 0
	_target_horizontal = 0
	
	active = false
	
	
func activate():
	active = true


