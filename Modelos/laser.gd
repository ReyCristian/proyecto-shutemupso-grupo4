extends Node2D

func _process(delta):
	var space_state = get_world_2d().direct_space_state
	var area_shape = $Area2D/CollisionShape2D.shape  # La forma de colisión del Area2D

	# Crear los parámetros de la consulta de colisión
	var shape_query = PhysicsShapeQueryParameters2D.new()
	shape_query.shape = area_shape
	shape_query.transform = Transform2D(get_global_transform())

	# Realizar la intersección
	var result = space_state.intersect_shape(shape_query)

	if result.size() > 0:
		for collision in result:
			if collision.collider.is_in_group("TileMapDestruible"):
				var tilemap:TileMapLayer = collision.collider
				var collision_point = $Area2D.global_position

				# Convertir la posición global de la colisión a la posición de celda del TileMap
				var cell_pos = tilemap.local_to_map(tilemap.to_local(collision_point))

				# Destruir el tile en esa posición
				tilemap.erase_cell(cell_pos)
				print("laser impacta en la posición:", collision_point)
				print("Tile destruido en la posición:", cell_pos)
				queue_free()

func _physics_process(delta: float) -> void:
	position.x += 150 *delta
	#print(position.x)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemigo"):
		queue_free()
		
