extends VisibleOnScreenEnabler2D



func _on_screen_entered() -> void:
	get_parent().esperando = false;
	self.queue_free();
	pass # Replace with function body.
