extends Node2D

export (float) var margin_h = 50
export (float) var margin_v = 40
var goal
var camera

func _process(delta):
	var rect_extent = get_viewport().size / 2
	
	var to_goal = goal.global_position - camera.global_position
	to_goal = vec_min(
		to_goal * ((rect_extent.x - margin_h) / max(abs(to_goal.x), 0.1)),
		to_goal * ((rect_extent.y - margin_v) / max(abs(to_goal.y), 0.1))
	)
	
	global_position = Vector2(512, 300) + to_goal
	var rot = (goal.global_position - camera.global_position + ($Sprite.global_position - Vector2(512, 300))).angle() + PI/2
	$Sprite.rotation = rot

func vec_min(a : Vector2, b : Vector2):
	return a if a.length_squared() < b.length_squared() else b

func init(goal, camera):
	self.goal = goal
	self.camera = camera