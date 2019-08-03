extends Control

export var buttonText = "Text here"

func _ready():
	$Label.text = buttonText

func rectSlideIn():
	$Tween.interpolate_property($Bg, "rect_position:x", -$Bg.get_rect().size.x, 0, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property($Bg, "modulate:a", 0, 0.6, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.start()
	
func appear():
	$AnimationPlayer.play("appear")
	rectSlideIn()