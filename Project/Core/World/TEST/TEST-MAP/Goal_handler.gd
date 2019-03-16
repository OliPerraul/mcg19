extends Node2D



var goal_array 		: Array
var goal_points		: Array
var goal_states		: Array


func _ready():

	goal_points = [self]
	goal_states = [true]
	
	
	for GOAL in get_children():
		goal_points.push_back(GOAL)
		goal_states.push_back(false)


func add():
	randomize()
	var vacant = _get_vacant()
	var index = randi()%vacant.size()
	
	#make at
	#goal_array[vacant[index]]
	goal_states[vacant[index]]=true
	print("add to"+String(goal_array[vacant[index]]))
	
	pass
	
func remove(G):
	var g = goal_array.find(G)
	#goal_array[g].free()
	
	goal_states[g] = false
	
	
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