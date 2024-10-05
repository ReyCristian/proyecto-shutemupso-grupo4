extends Area2D

func obtener_punto_aleatorio_area() -> Vector2:
	return Vector2(
		randi_range(int(global_position.x) - tamaño().x / 2, int(global_position.x) + tamaño().x / 2),
		randi_range(int(global_position.y) - tamaño().y / 2, int(global_position.y) + tamaño().y / 2)
	)

func tamaño() -> Vector2:
	return get_node("CollisionShape2D").shape.extents * 2


func _on_timer_cambiar_posicion() -> void:
	$proxima_posicion.global_position = obtener_punto_aleatorio_area()
	pass 
