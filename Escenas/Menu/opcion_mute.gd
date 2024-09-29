extends CheckButton

func _on_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),toggled_on)
	pass # Replace with function body.
