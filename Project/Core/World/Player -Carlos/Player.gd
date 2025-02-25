
extends KinematicBody2D



#CHILD NODES TO load
var footprints
var sprite
var area_2D
var sfx_player: AudioStreamPlayer2D


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


export(Array, AudioStream) onready var soundArray
#PRIVATES

var movement : Vector2 = Vector2(0,0)


export(float) var foot_print_distance = 20
var _last_foot_pos = Vector2(INF, INF)

var can_move = true
var hiding_place = null

func _ready():
	footprints = get_node("Footprints")
	sprite = get_node("sprite")
	area_2D = get_node("area_2D")
	add_to_group("detectable")
	sfx_player = get_node("AudioStreamPlayer2D")



func _process(dt):
	if not Vectors.close_enough(_last_foot_pos, global_position, foot_print_distance):
		footprints.add(facing)
		_last_foot_pos = global_position
		


func input_handler():

	movement = Vector2(0, 0)

	#movement input
	if Input.is_action_pressed("player_up"):
		animation_state = "walking"
		facing = "north"
		movement.y -= 1
		sfx_player.stop()

	if Input.is_action_pressed("player_down"):
		animation_state = "walking"
		facing = "south"
		movement.y += 1	
		sfx_player.stop()

	if Input.is_action_pressed("player_left"):
		animation_state = "walking"
		facing = "west"
		movement.x -= 1
		sfx_player.stop()

	if Input.is_action_pressed("player_right"):
		animation_state = "walking"
		facing = "east"
		movement.x += 1
		sfx_player.stop()

	#NO net movement
	if movement ==Vector2(0,0):
		animation_state = "idle"
		movement = Vector2(0,0)
		if ! sfx_player.playing:
			sfx_player.play()


#	if Input.is_action_just_released("ui_accept"):
#		get_parent().get_parent().get_node("GOALS").add()
#		print(get_parent().get_parent().get_node("GOALS"))

	#if Input.is_action_just_released("ui_cancel"):
		#get_parent().get_parent().get_node("GOALS").remove()

	movement = movement.normalized()





func _player_set_visible():
	$sprite.visible = true

func _player_set_invisible():
	$sprite.visible = false


#states
func _player_normal():
	move_and_slide(movement * 250)
	pass

func _player_danger_update():
	#no movement
	pass

func _player_enable_hide_update():
	if Input.is_action_just_released("ui_accept"):
		init_state("hidden")
		
	if cover != null and not cover.area.overlaps_body(self): # goes outside
		init_state("normal")		
		cover = null
		
		
func _player_hidden_update():
	if cover != null :	
		global_position = lerp(global_position, cover.global_position, hide_speed)
		if Vectors.close_enough(global_position, cover.global_position):
			z_index = 1 
			cover.z_index = 20
		priority = -1
		
	if Input.is_action_just_released("ui_accept"):
		init_state("normal")

func _player_normal_update():
	move_and_slide(movement*250)
	pass


func _player_hidden():
	if Input.is_action_just_released("ui_accept"):
		init_state("normal")

func player_hide(cover):
	init_state('enable_hide', [cover])



func _physics_process(dt):
	input_handler()
	update_state(character_state)



func update_state(state):	
	match(state):
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
			_player_hidden_update()
					
		"enable_hide":    #DISPLAY UI HERE\
			z_index = 2
			cover.z_index = 1
			_player_normal_update()	
			_player_enable_hide_update()

		"normal":
			_player_normal_update()	


func init_state(state, args=[]):
	if state == character_state:
		return 								
	match(state):
		
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
			priority = -1
					
						
		"enable_hide":    #DISPLAY UI HERE
			if character_state == 'hidden':
				return							
			self.cover = args[0]

		
			
		#continue #also do normal movement
		"normal":
			priority = 100
			z_index = 1
			if(cover!= null):
				cover.z_index = 0
				self.cover = null
			pass
		
	# Assigned state if not returned early
	character_state = state			



func _player_lock():
	init_state('locked')

func _player_unlock():
	init_state('normal')


func _on_HideTween_tween_completed(object, key):
	init_state("hidden")
	


