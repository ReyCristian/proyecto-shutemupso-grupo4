extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("laser")
	$AnimationPlayer2.play("recorte")
	var game_time = float(Time.get_ticks_msec() % 1000)/1000
	$AnimationPlayer.seek(1-game_time, true)
	
func seleccionar_laser(color: int):
	match color:
		1:
			$LaserRojo.visible = true;
			$LaserAzul.visible = false;
		2:
			$LaserRojo.visible = false;
			$LaserAzul.visible = true;
		

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
				#print("desaparece laser contra tile")
				queue_free()

	
func _physics_process(delta: float) -> void:
	var direccion = Vector2.from_angle(rotation)
	position += direccion* 150 *delta
	
	#print(position.x)

	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	#if is_in_group("laser_p"):
	#	print("desaparece laser fuera pantalla")
	queue_free()
	pass

'''
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemigo"):
		print("desaparece laser contra enemigo")
		queue_free()
'''
