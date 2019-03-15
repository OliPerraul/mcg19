extends 'res://Core/World/OpenContent/OpenNode.gd'


export(NodePath) onready var _kinematic_body


var body_just_entered = false


# Member variables
export var motion = Vector2()
export var cycle = 1.0
var accum = 0.0


func _ready():
	_kinematic_body = get_node(_kinematic_body)
	hit_box.connect('body_entered', self, '_on_body_entered')
	hit_box.connect('body_exited', self, '_on_body_exited')

func _process(delta):	
	accum += delta * (1.0 / cycle) * PI * 2.0
	accum = fmod(accum, PI * 2.0)
	var d = 1-cos(accum)
	var xf = Transform2D()
	xf[2]= motion * d 
	_kinematic_body.transform = xf

func _on_body_entered(body):
	if not Nodes.is_child(body, _kinematic_body) && body.is_in_group('Player') :
		Nodes.call_deferred('set_parent_preserve_common_space_position', body, _kinematic_body) 
				
func _on_body_exited(body):
	if Nodes.is_child(body, _kinematic_body) && body.is_in_group('Player') :
		Nodes.call_deferred('set_parent_preserve_common_space_position', body, Globals.world.middleground) 

