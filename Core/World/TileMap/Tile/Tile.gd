extends Node

export(NodePath) onready var static_body


func _ready():
	static_body = get_node(static_body)
	static_body.set_collision_layer_bit(CollisionLayers.SOLIDS, true)
	static_body.set_collision_layer_bit(CollisionLayers.TILES, true)