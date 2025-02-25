extends Node2D

export(NodePath) onready var __char
var _char


const DETECT_RADIUS = 120
export(float) onready var FOV = 60
var angle = 0


var target = null
var hit_pos

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
				#raycast here
				var space_state = get_world_2d().direct_space_state
				var result = space_state.intersect_ray(pos, other_pos)
				if result:
#					hit_pos = result.position
#					if result.collider.name == "Player" :
#						if node.priority < 0:
#							continue
					if node.priority > prio:
						target = node
						prio = node.priority
						
	# DRAWING
	update()







# Drawing the FOV
const RED = Color(1.0, .5, .5, 0.5)
const GREEN = Color(1.0, 1.0, 1.0, .5)
const YELLOW = Color(1, 1, .1, .4)
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
	
	
	