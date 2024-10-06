extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("laser")
	$AnimationPlayer2.play("recorte")
	if not is_in_group("demo"):
		$Sonido.play()
	rotar_fase_laser();

func _physics_process(delta: float) -> void:
	var direccion = Vector2.from_angle(rotation)
	if not verificar_si_esta_en_camino_fijo(delta):
		position += direccion * 150 * delta
	detectar_golpes();

func verificar_si_esta_en_camino_fijo(delta) -> bool:
	if get_parent() is PathFollow2D and get_parent().progress_ratio < 1:
		get_parent().progress += 150 * delta
		return true;
	else:
		return false;

func detectar_golpes():
	var golpeados = $Area2D.get_overlapping_bodies()
	if golpeados.size() > 0:
		for golpeado in golpeados:
			romper_tile_destruible(golpeado)

func romper_tile_destruible(golpeado):
	if golpeado.is_in_group("TileMapDestruible"):
		var punto_colision = $Area2D.global_position
		golpeado.romper_posicion_global(punto_colision)
		queue_free()


func rotar_fase_laser():
	# Esta funcion retrasa un poco la animacion para darle un sentido
	# de giro en el lanzamiento del laser, para q no se vea tan estatico
	var game_time = float(Time.get_ticks_msec() % 1000)/1000
	$AnimationPlayer.seek(1-game_time, true)

# Esta funcion la llama el personaje que dispare el laser
func seleccionar_laser(color: int):
	match color:
		1:
			$LaserRojo.visible = true;
			$LaserAzul.visible = false;
		2:
			$LaserRojo.visible = false;
			$LaserAzul.visible = true;

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if not get_parent() is PathFollow2D:
		queue_free();
	elif get_parent().progress_ratio >= 1:
		queue_free();
		liberar_camino();
	pass

func liberar_camino():
	var camino = get_parent().get_parent()
	if camino.is_in_group("liberar_al_morir"):
		camino.get_parent().remove_child(camino)
		camino.queue_free()
