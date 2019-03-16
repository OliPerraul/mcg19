extends Node2D

func _process(delta):
	pass
	#$Sprite.rotate(delta)

func _input(event):
	if event is InputEventMouseMotion:
		$ColorRect.rect_global_position = event.position - Vector2(256, 150)
		var rot = (event.position - $Sprite.global_position).angle() + PI/2
		$Label.text = str(rot)
		$Sprite.rotation = rot