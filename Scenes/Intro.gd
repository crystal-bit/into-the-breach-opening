extends Node2D
tool

export(bool) var updateScreen = false
export(bool) var reset = false

export(int) var distance = 750
export(int) var duration = 5

func _ready():
	resizeEverything()
	fillHorizontalSpace()
	# on resize, update the background
	get_viewport().connect("size_changed", self, "resizeEverything")
	
	for c in get_children():
		if c.name != "Tween":
			print(typeof(c))
			c.get_node("Tween").interpolate_property(c, "position", c.position, c.position + Vector2(-distance, 0), duration, Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
			c.get_node("Tween").start()

func resizeEverything():
	removeDuplicateSprites()
	updateHeight()
	fillHorizontalSpace()

func removeDuplicateSprites():
	for c in get_children():
		if c != $SkylineA:
			c.queue_free()

func _process(delta):
	if updateScreen:
		_ready()
		updateScreen = false
	if reset:
		for c in get_children():
			if c != $SkylineA:
				c.queue_free()
		reset = false

func fillHorizontalSpace():
	var number_of_sprites = get_viewport_rect().size.x / ($SkylineA.get_rect().size.x * $SkylineA.scale.x)
	var previousSpr = $SkylineA
	for i in ceil(number_of_sprites):
		var tileSpr = $SkylineA.duplicate(DUPLICATE_USE_INSTANCING)
		tileSpr.position.x = previousSpr.position.x + previousSpr.get_rect().size.x * previousSpr.scale.x
		previousSpr = tileSpr
		add_child(tileSpr)
		
func updateHeight():
	var missing_height = get_viewport_rect().size.y - $SkylineA.get_rect().size.y
	if missing_height > 0 :
		# scale sprite
		var scale_factor = ($SkylineA.get_rect().size.y + missing_height) / $SkylineA.get_rect().size.y
		$SkylineA.scale = Vector2(scale_factor, scale_factor)
