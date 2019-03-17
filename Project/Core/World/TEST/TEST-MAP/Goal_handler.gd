extends Node2D


export(Resource) var Garbage

var goal_array 		: Array
var goal_points		: Array
var goal_states		: Array

var GoalDirection = preload("res://Core/World/Events - Jason/GoalDirection.tscn")

signal on_destroy
var first_trash = true

func _ready():

	goal_points = [self]
	goal_states = [true]
	goal_array = [Garbage.instance()]
	goal_array[0].position = goal_points[0].position
	goal_array[0].z_index = 1
	add_child(goal_array[0])
	
	for GOAL in get_children():
		goal_points.push_back(GOAL)
		goal_states.push_back(false)
		goal_array.push_back(null)


func add():
	randomize()
	var vacant = _get_vacant()
	if(vacant.size()==0): return
	var index = randi()%vacant.size()
	
	#make at
	goal_array[vacant[index]] = Garbage.instance()
	add_child(goal_array[vacant[index]])
	goal_states[vacant[index]]=true
	goal_array[vacant[index]].z_index = 1
	goal_array[vacant[index]].position = goal_points[vacant[index]].position
	print("add ", index, " to " + str(goal_points[vacant[index]].global_position))
	
	var dial = GoalDirection.instance()
	dial.init(goal_array[vacant[index]], $"../Middleground/Player/Camera2D")
	$"../CanvasLayer".add_child(dial)
	goal_array[vacant[index]].dial = dial
	
	get_parent().goal = goal_array[vacant[index]]
	


func remove(G):
	emit_signal("on_destroy", G)
	var g = goal_array.find(G)
	#goal_array[g].free()	
	goal_states[g] = false
	goal_array[g].dial.queue_free()
	goal_array[g].queue_free()
	
	
func _get_vacant():
	var output = []
	var off = 0
	var s
	s=goal_states.find(false,off)
	while(s != -1):
		output.push_back(s)
		off = s+1
		s=goal_states.find(false,off)
	
	return output