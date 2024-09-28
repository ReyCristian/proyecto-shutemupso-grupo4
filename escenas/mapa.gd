extends Node2D

@export var velocidad = 25
@export var Fin_del_mapa = 3500

func _process(delta: float) -> void:
	if (position.y <Fin_del_mapa):
		position.y += velocidad * delta
	
