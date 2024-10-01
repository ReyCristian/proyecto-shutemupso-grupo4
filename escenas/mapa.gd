extends Node2D

@export var velocidad = 25
@export var Fin_del_mapa = 3500

var archivo_escena:PackedScene;

func _process(delta: float) -> void:
	#Avanza hasta el fin del mapa a una velocidad dada
	if (position.y < Fin_del_mapa):
		position.y += velocidad * delta
	
