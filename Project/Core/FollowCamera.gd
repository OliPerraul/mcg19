# Camera that smoothly transitions from a room to the next, using steering (we apply a force so it slows down as it approaches its target)
extends Camera2D


export(NodePath) onready var __player
var _player

export(Vector2) var offset_ = Vector2(0,64)
export(float) var speed = 50
export(float) var slow_distance = 10

onready var window_size = OS.get_window_size()
onready var player_pos = Vector2(-INF,-INF)

var target_pos = Vector2()
var velocity = Vector2()


func _ready():
	call_deferred("_post_ready")

func _post_ready():
	_player =  get_node(__player)
	_player.connect("moving", self, "update_camera")
	_player.connect('path_changed', self, 'update_camera')
		
	# Initialize the camera's position. It's the center of the room the player is in.
	# It's very important to store the position in a member variable, pos here
	update_camera()
	position = target_pos


func _process(delta):
	# If the camera is far from its target, it will move at its maximum speed.
	# We will only apply the counter force and slow it down as it approaches the target.
	var distance_to_target = position.distance_to(target_pos)
	
	if distance_to_target < slow_distance:
		# The only difference in velocity is the division at the end to smoothly slow the camera down
		velocity = (target_pos - position).normalized() * speed * delta * (distance_to_target / slow_distance)
	else:
		# We create a vector pointing towards the target, normalize it so it has a length of 1
		# Once we multiply it by speed * delta, we ensure that the camera will move at speed px/s
		velocity = (target_pos - position).normalized() * speed * delta
	
	position = position.linear_interpolate(target_pos,speed)
	
	# The camera will jitter around the target if we don't force it to stop at some point
	if distance_to_target < .05 :
		position = target_pos
		set_process(false)


func update_camera():
	# Similar to example 02, but we don't move the camera. We just set its ta  rget_pos
	# Then we set it to process every frame so we can move it smoothly, independently from the player
	var new_player_pos = get_player_pos()
		
	if new_player_pos != player_pos:
		player_pos = new_player_pos
		target_pos = new_player_pos+offset_
		set_process(true)
	return new_player_pos


func get_player_pos():
	# Converts the player position in px to his position on the world grid
	var pos = Nodes.get_space_global_position(_player, Globals.world) - _player.hit_box.get_size() / 2
	return pos
