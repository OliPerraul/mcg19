extends Node2D

export (NodePath) var goal
export var margin_h = 50
var margin_v = 40

func _input(event):
	if event is InputEventMouseMotion:
		var rect_extent = get_viewport().size / 2
		
		var to_goal = get_node(goal).position - event.position
		
		to_goal = vec_min(
			to_goal * ((rect_extent.x - margin_h) / max(abs(to_goal.x), 0.1)),
			to_goal * ((rect_extent.y - margin_v) / max(abs(to_goal.y), 0.1))
		)
		
		position = event.position + to_goal
		var rot = (get_node(goal).position - $Sprite.global_position).angle() + PI/2
		$Sprite.rotation = rot

func vec_min(a : Vector2, b : Vector2):
	return a if a.length_squared() < b.length_squared() else b