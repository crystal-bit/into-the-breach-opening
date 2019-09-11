extends CanvasLayer

onready var spaceship = get_parent().get_node("Spaceship")

func _ready():
	if !$OptionsSubmenu.config.get_value("general", "showSpaceship"):
		spaceship.hide()
	
	$ProfileName.text = "Profile = " + $OptionsSubmenu.config.get_value("general", "playerName")
	# TODO
	$Money.text = "Money = " + str($OptionsSubmenu.config.get_value("general", "money"))
		
func _on_MainButtons_optionsButtonClicked():
	$OptionsSubmenu.show()

