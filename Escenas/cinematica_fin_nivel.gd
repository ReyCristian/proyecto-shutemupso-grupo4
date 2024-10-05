extends Node2D

func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	var nivel = get_tree().get_first_node_in_group("nivel")
	for nodo in get_tree().get_nodes_in_group("liberar_al_final"):
		if nivel.is_ancestor_of(nodo):
			nodo.queue_free()
	for enemigo in get_tree().get_nodes_in_group("enemigo"):
		if nivel.is_ancestor_of(enemigo):
			enemigo.remove_from_group("enemigo");
			enemigo.hitbox.morir();
	for heroe in get_tree().get_nodes_in_group("heroe"):
		if nivel.is_ancestor_of(heroe):
			agregar_heroe_al_camino_final(heroe)
			poner_valores_movimiento(heroe,nivel)
			crear_señal_heroe_saliendo(heroe)

#Esta Funcion se llama cuando el heroe sale del nivel
func _on_heroe_screen_exited():
	var principal = get_tree().get_first_node_in_group("principal");
	principal.siguiente_nivel();

func crear_señal_heroe_saliendo(heroe):
	await get_tree().create_timer(1).timeout
	heroe.get_node("VisibleOnScreenNotifier2D").connect("screen_exited",_on_heroe_screen_exited)
	
func agregar_heroe_al_camino_final(heroe):
	var pos = heroe.global_position
	heroe.add_to_group("demo")
	$Path2D.curve.set_point_position(0,$Path2D.to_local(pos))
	heroe.get_parent().remove_child(heroe)
	$Path2D/PathFollow2D.add_child(heroe);
	heroe.position = Vector2.ZERO
	$Path2D/PathFollow2D.progress = 0;
	

func poner_valores_movimiento(heroe,nivel):
	await get_tree().create_timer(0.1).timeout
	heroe.direccion = Vector2.ZERO
	heroe.magia.detener_shot();
	heroe.auto_movimiento = Vector2.ZERO
	heroe.auto_movimiento.y = -float(nivel.velocidad*2) / 100;
