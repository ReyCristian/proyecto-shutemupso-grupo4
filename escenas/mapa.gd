extends Node2D

<<<<<<< HEAD
@export var velocidad = 20
=======
@export var velocidad = 25
>>>>>>> e73fa1949f9ab55f7fb2561549c2c1b278f1f800

func _process(delta: float) -> void:
	if (position.y <3500):
		position.y += velocidad * delta
	
