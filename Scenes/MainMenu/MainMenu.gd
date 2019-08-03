extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _on_ScrollingBackground_transition_completed():
	showMenu()

func showMenu():
	$AnimationPlayer.play("MenuAppear")
