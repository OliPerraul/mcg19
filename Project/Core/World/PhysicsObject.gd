extends KinematicBody2D

const _GRAV = 20
const _SPEED = 20
const _JUMP_HEIGHT = -550

var _motion = Vector2()


func _physics_process(delta):
	_motion.y += _GRAV
	
	if Input.is_action_just_pressed("ui_right"):
		_motion.x = _SPEED
	elif Input.is_action_just_pressed("ui_left"):
		_motion.x = -_SPEED
	else:
		_motion.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			_motion.y = _JUMP_HEIGHT
	
	_motion = move_and_slide(_motion, Vectors.UP)