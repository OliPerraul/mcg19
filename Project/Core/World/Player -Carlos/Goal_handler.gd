extends Node2D


export(Resource) map 

var goal_array 		: Array
var starting_goal 	: Position2D
var goals			: Position2D



func _ready():
	starting_goal = map.get_node("GOALS")

	goal_array = [starting_goal]
	for GOAL in starting_goal.get_children():
		goal_array.push_back(GOAL)

	
	print(goal_array)	
		

