extends Node2D

@export var velocidad = 25

func _process(delta: float) -> void:
	if (position.y <3500):
		position.y += velocidad * delta
	
