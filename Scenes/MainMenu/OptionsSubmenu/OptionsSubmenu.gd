extends Panel

var initialValues = {}
var SAVE_FILE_PATH = "res://settings.cfg" 

func _ready():
	getSaveFile()
	
# this overrides the default show() method
func show():
	# save variables state
	initialValues = {
		"showSpaceship": $VBoxContainer/ShowSpaceShip/CheckBox.pressed,
		"volume": $VBoxContainer/Volume/HSlider.value,
		"playerName": $VBoxContainer/PlayerName/LineEdit.text
	}
	visible = true
	getSaveFile()
	# reset initial values
	$VBoxContainer/ShowSpaceShip/CheckBox.pressed = initialValues.showSpaceship
	$VBoxContainer/Volume/HSlider.value = initialValues.volume
	$VBoxContainer/PlayerName/LineEdit.text = initialValues.playerName

func _on_Cancel_pressed():
	hide()
	# reset initial values
	$VBoxContainer/ShowSpaceShip/CheckBox.pressed = initialValues.showSpaceship
	$VBoxContainer/Volume/HSlider.value = initialValues.volume
	$VBoxContainer/PlayerName/LineEdit.text = initialValues.playerName


func _on_Ok_pressed():
	hide()
	var data = {
		"showSpaceship": $VBoxContainer/ShowSpaceShip/CheckBox.pressed,
		"volume": $VBoxContainer/Volume/HSlider.value,
		"playerName": $VBoxContainer/PlayerName/LineEdit.text
	}
	saveConfig(data)

func getSaveFile():
	var config = ConfigFile.new()
	# creates file if it does not exists
	var f = File.new()
	if !f.file_exists(SAVE_FILE_PATH):
		config.save(SAVE_FILE_PATH)
	
	var err = config.load(SAVE_FILE_PATH)
	if err == OK:	
		# check if keys exist. If not, set them to default values
		if not config.has_section_key("general", "playerName"):
			config.set_value("general", "playerName", "")
		if not config.has_section_key("general", "showSpaceship"):
			config.set_value("general", "showSpaceship", true)
		if not config.has_section_key("audio", "volume"):
			config.set_value("audio", "volume", 0)
		
		initialValues = {
			"playerName": config.get_value("general", "playerName"),
			"showSpaceship": config.get_value("general", "showSpaceship"),
			"volume": config.get_value("audio", "volume"),
		}
		# Save the changes by overwriting the previous file
		config.save(SAVE_FILE_PATH)
	else:
		print("Error while loading config", err)

func saveConfig(data):
	var config = ConfigFile.new()
	
	# creates file if it does not exists
	var f = File.new()
	if !f.file_exists(SAVE_FILE_PATH):
		config.save(SAVE_FILE_PATH)
	
	var err = config.load(SAVE_FILE_PATH)
	if err == OK:
		config.set_value("general", "playerName", data.playerName)
		config.set_value("general", "showSpaceship", data.showSpaceship)
		config.set_value("audio", "volume", data.volume)
		# Save the changes by overwriting the previous file
		config.save(SAVE_FILE_PATH)
	else:
		print("Error while loading config", err)
	