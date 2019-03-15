extends 'Controller.gd'


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if active :
		# LRDU
		_target_horizontal = 0
		_target_vertical = 0
		
		if Input.is_action_pressed("ui_left") :
			_target_horizontal = -1
			
		if Input.is_action_pressed("ui_right") :
			_target_horizontal = 1
			
		if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_right"):
			_target_horizontal = 0
			
		if Input.is_action_pressed("ui_down") :
			_target_vertical = -1
			
		if Input.is_action_pressed("ui_up") :
			_target_vertical = 1
		
		if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_down"):
			_target_vertical = 0
			
		
		# Lerp towards target axis values	
		
		horizontal = lerp(horizontal, _target_horizontal, _AXIS_LERP_AMOUNT)
		horizontal = Floats.approximate(horizontal)
		
		vertical = lerp(vertical, _target_vertical, _AXIS_LERP_AMOUNT)
		vertical = Floats.approximate(vertical)
		
		
		# Jump	
			
		if Input.is_action_just_pressed("ui_select"):
			jump_pressed = true
		else:
			jump_pressed = false
		
		if Input.is_action_pressed("ui_select"):
			jump_checked = true
		else:
			jump_checked = false


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


