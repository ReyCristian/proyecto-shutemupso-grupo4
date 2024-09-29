extends AudioStreamPlayer

func _ready() -> void:
	# Cuando termina
	self.connect("finished",_on_finished)

func _on_finished() -> void:
	# Vueve a empezar
	play();
	pass
