tool
extends Node2D

export(NodePath) onready var __char
var _char


const DETECT_RADIUS = 360
const FOV = 60
var angle = 0


var target = null


func _ready():
	_char = get_node(__char)
	pass


func _process(delta):
	var pos = global_transform.origin
	angle = rad2deg(_char.direction.angle())

	var detect_count = 0
	target = null
	var prio = -INF
	for node in get_tree().get_nodes_in_group('detectable'):
		var other_pos = node.global_transform.origin
		#print(pos.distance_to(other_pos))
		if pos.distance_to(other_pos) < DETECT_RADIUS:		
			var direction_to_npc = (other_pos - pos).normalized()
			var angle_to_node = rad2deg(_char.direction.angle_to(direction_to_npc))
			if abs(angle_to_node) < FOV/2:
				if node.priority > prio:
					target = node
					prio = node.priority
					
	# DRAWING
	if target != null:
		draw_color = RED
	else:
		draw_color = GREEN
	update()







# Drawing the FOV
const RED = Color(1.0, 0, 0, 0.4)
const GREEN = Color(0, 1.0, 0, 0.4)

var draw_color = GREEN


func _draw():
	draw_circle_arc_poly(Vector2(), DETECT_RADIUS,  angle - FOV/2, angle + FOV/2, draw_color)


func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = Array()
    points_arc.push_back(center)
    var colors = Array([color])

    for i in range(nb_points+1):
        var angle_point = angle_from + i*(angle_to-angle_from)/nb_points
        points_arc.push_back(center + Vector2( cos( deg2rad(angle_point) ), sin( deg2rad(angle_point) ) ) * radius)
    draw_polygon(points_arc, colors)
	
	
	