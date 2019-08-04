extends Control

signal menuAppeared

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartGame/Bg.modulate.a = 0
	$VBoxContainer/Options/Bg.modulate.a = 0
	$VBoxContainer/Exit/Bg.modulate.a = 0

func showMenu():
	$AnimationPlayer.play("MenuAppear")
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "MenuAppear"):
		emit_signal("menuAppeared")


func _on_ScrollingBackground_transition_updated(completionPercentage, _moonXPos):
	if completionPercentage > 0.75 && $VBoxContainer/StartGame/Label.modulate.a == 0:
		showMenu()
