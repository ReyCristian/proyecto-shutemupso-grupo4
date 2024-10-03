extends Node

@export var tipo_enemigo:String;

func _on_personaje_muere() -> void:
	var principal = get_tree().get_nodes_in_group("principal")[0]
	principal.dame_puntaje()[tipo_enemigo] +=1;
	print(principal.dame_puntaje())
