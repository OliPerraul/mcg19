extends KinematicBody2D



#CHILD NODES TO load
var footprints
var sprite
var area_2D


#EXPORTED
export(String) var facing = "south"
# 	north
# 	east
# 	south
# 	west
export(String) var animation_state



# 	idle
# 	walking
# 	hidden
var cover = null
var hide_speed = .2
export(String) var character_state = "normal"





#	normal
# 	locked
#	danger
#	involuntary
export(float) var speed = 4
export(float) var animation_speed = 0.1


export(float) onready var priority = 100
onready var type = Globals.DETECTABLE.PLAYER

#PRIVATES

var movement : Vector2 = Vector2(0,0)


export(float) var foot_print_distance = 20
var _last_foot_pos = Vector2(INF, INF)



func _ready():
	call_deferred("_post_ready")

func _post_ready():
	# load nodes
	#footprints = preload("Footprints.tscn").instance()
	footprints = get_node("Footprints")
	sprite = get_node("sprite")
	area_2D = get_node("area_2D")
	add_to_group("detectable")



func _process(delta):
	if not Vectors.close_enough(_last_foot_pos, global_position, foot_print_distance):
		footprints.add(facing)
		_last_foot_pos = global_position
	

func _physics_process(dt):
	match(character_state): #str comparison lol
		"normal":
			input_handler()
			_player_normal()					
		"locked":
			pass
			#_player_set_locked()
		"danger":
			pass
			#_player_danger()
		"involuntary":
			pass
			#_player_involuntary()
		"hidden":
			_player_hidden()
					
		"enable_hide":    #DISPLAY UI HERE
			input_handler()
			_player_normal() # also run normal
			_player_enable_hide()			

			
			#_player_involuntary()

			



func input_handler():

	movement = Vector2(0,0)

	if Input.is_action_pressed("player_up"):
		animation_state = "walking"
		facing = "north"
		movement.y -= 1

	if Input.is_action_pressed("player_down"):
		animation_state = "walking"
		facing = "south"
		movement.y += 1

	if Input.is_action_pressed("player_left"):
		animation_state = "walking"
		facing = "west"
		movement.x -= 1

	if Input.is_action_pressed("player_right"):
		animation_state = "walking"
		facing = "east"
		movement.x += 1

	#if Input.is_action_just_released("player_movement"):
	if movement==Vector2(0,0):
		animation_state = "idle"
		movement = Vector2(0,0)

		

	movement = movement.normalized()



func _player_lock():
	pass

func _player_unlock():
	pass

func _player_set_visible():
	pass

func _player_set_invisible():
	pass


#states
func _player_normal():
	move_and_slide(movement*250)
	pass

func _player_danger():
	#no movement
	pass

func _player_enable_hide():
	if Input.is_action_just_released("ui_accept"):
		character_state = "hidden"
		
	if cover != null and not cover.area.overlaps_body(self): # goes outside
		character_state = "normal"		
		cover = null


func _player_hidden():
	if cover != null :	
		global_position = lerp(global_position, cover.global_position, hide_speed)
		priority = -1
		
	if Input.is_action_just_released("ui_accept"):
		character_state = "normal"
		priority = 100			
	

func player_hide(cover):
	if character_state != "hidden":
		self.cover = cover
		character_state = "enable_hide"


	
	
