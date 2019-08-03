extends Button


func _ready():
	pass

func appear():
	$Tween.interpolate_property(self, "rect_position:x", -get_rect().size.x, 0, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()