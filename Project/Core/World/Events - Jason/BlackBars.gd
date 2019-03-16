extends Control

export (float) var duration = 0.5
var activated = false

func activate_bars():
	$Tween.interpolate_property($UpperBar, "rect_size", $UpperBar.rect_size, Vector2(1024, 100), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($LowerBar, "rect_size", $LowerBar.rect_size, Vector2(1024, 100), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	activated = true

func deactivate_bars():
	$Tween.interpolate_property($UpperBar, "rect_size", $UpperBar.rect_size, Vector2(1024, 0), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property($LowerBar, "rect_size", $LowerBar.rect_size, Vector2(1024, 0), duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	activated = false