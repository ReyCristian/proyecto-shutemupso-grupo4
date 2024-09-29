extends CheckButton

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mute"):
		self.button_pressed = not self.button_pressed

func _on_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),toggled_on)
	pass # Replace with function body.
