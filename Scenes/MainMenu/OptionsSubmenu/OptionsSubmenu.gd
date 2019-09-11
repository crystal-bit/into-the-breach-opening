extends Panel

var SAVE_FILE_PATH = "res://settings.cfg" 

var config: ConfigFile

func _ready():
	config = getConfigFile()
	
	# check if keys exist. If not, set them to default values
	if not config.has_section_key("general", "playerName"):
		config.set_value("general", "playerName", "")
	if not config.has_section_key("general", "showSpaceship"):
		config.set_value("general", "showSpaceship", true)
	if not config.has_section_key("audio", "volume"):
		config.set_value("audio", "volume", 0)
		
#	initialValues = getDictionaryFromConfigFile(config)
	# Save the changes by overwriting the previous file
	config.save(SAVE_FILE_PATH)	
	

func show():
	"""This overrides the default show() method."""
	visible = true
	setSceneValuesFromConfig(config)

func _on_Cancel_pressed():
	hide()
	# reset initial values
	setSceneValuesFromConfig(config)


func _on_Ok_pressed():
	hide()
	var data = {
		"showSpaceship": $VBoxContainer/ShowSpaceShip/CheckBox.pressed,
		"volume": $VBoxContainer/Volume/HSlider.value,
		"playerName": $VBoxContainer/PlayerName/LineEdit.text
	}
	saveConfig(config, data)


func getConfigFile() -> ConfigFile:
	""" Loads the ConfigFile and returns it. 
	If unsuccesfull returns an error code. 
	"""
	var config = ConfigFile.new()
	var f = File.new()
	# creates file if it does not exists
	if !f.file_exists(SAVE_FILE_PATH):
		config.save(SAVE_FILE_PATH)
	# load the file
	var err = config.load(SAVE_FILE_PATH)
	# if file loaded
	if err == OK:
		# return it
		return config
	else:
		print("Error while loading config", err)
		return err


func setSceneValuesFromConfig(config: ConfigFile):
	$VBoxContainer/ShowSpaceShip/CheckBox.pressed = config.get_value("general", "showSpaceship")
	$VBoxContainer/Volume/HSlider.value = config.get_value("audio", "volume")
	$VBoxContainer/PlayerName/LineEdit.text = config.get_value("general", "playerName")


func saveConfig(config, data):
	var err = config.load(SAVE_FILE_PATH)
	if err == OK:
		config.set_value("general", "playerName", data.playerName)
		config.set_value("general", "showSpaceship", data.showSpaceship)
		config.set_value("audio", "volume", data.volume)
		# Save the changes by overwriting the previous file
		config.save(SAVE_FILE_PATH)
	else:
		print("Error while loading config", err)
	