extends CheckButton

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mute"):
		self.button_pressed = not self.button_pressed

func _al_cambiar(nuevo_valor: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),nuevo_valor)
	pass # Replace with function body.
