extends Node2D

@export var velocidad = 25
@export var Fin_del_mapa = 3500

var archivo_escena:PackedScene;

func _process(delta: float) -> void:
	#Avanza hasta el fin del mapa a una velocidad dada
	if (Fin_del_mapa == 0 or position.y < Fin_del_mapa):
		position.y += velocidad * delta
	
func saltar_al_final():
	position.y = 2500;
	$Personaje_principal.position = Vector2(240,-2427);

func detener():
	Fin_del_mapa = 1
	for fondo in get_tree().get_nodes_in_group("parallax"):
		fondo.velocidad = 0;
	
