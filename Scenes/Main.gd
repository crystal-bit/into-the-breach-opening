extends Node2D


func _ready():
	pass # Replace with function body.

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "spaceshipArrives"):
		$Spaceship/Sprite/AnimationPlayer.play("idle")

func _on_ScrollingBackground_transition_updated(completionPercentage, _moonXPos):
	if completionPercentage > 0.55 and $Spaceship.modulate.a == 0:
		$Spaceship/AnimationPlayer.play("spaceshipArrives")
		
		
