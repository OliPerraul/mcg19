extends Area2D



func _ready():
	set_pickable(true)

func get_size():
	return get_child(0).get_shape().get_extents()*2

