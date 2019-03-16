extends Node2D

func _process(delta):
	pass
	#$Sprite.rotate(delta)

func _input(event):
	if event is InputEventMouseMotion:
		#$ReferenceRect.rect_position = event.position
		var rot = (event.position - $Sprite.global_position).angle() + PI/2
		$Label.text = str(rot)
		$Sprite.rotation = rot
