extends CheckButton

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("full_screen"):
		self.button_pressed = not self.button_pressed

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass 
