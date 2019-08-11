extends CanvasLayer

onready var spaceship = get_parent().get_node("Spaceship")

func _ready():
	if !$OptionsSubmenu.initialValues.showSpaceship:
		spaceship.hide()
		
func _on_MainButtons_optionsButtonClicked():
	$OptionsSubmenu.show()

