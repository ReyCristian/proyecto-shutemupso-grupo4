extends CheckButton

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("full_screen"):
		self.button_pressed = not self.button_pressed

func _al_cambiar(nuevo_valor: bool) -> void:
	if nuevo_valor:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass 
