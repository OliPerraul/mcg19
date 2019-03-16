extends Node2D

func _process(delta):
	$Sprite.rotate(delta)

func _input(event):
	if event is InputEventMouseMotion:
		$Sprite.rotation = $Sprite.position.angle_to_point(event.position)
