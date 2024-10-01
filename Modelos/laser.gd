extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("laser")
	$AnimationPlayer2.play("recorte") 
	rotar_fase_laser();
	
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
		

func _process(_delta):
	var golpeados = $Area2D.get_overlapping_bodies()
	if golpeados.size() > 0:
		for golpeado in golpeados:
			romper_tile_destruible(golpeado)

func romper_tile_destruible(golpeado):
	if golpeado.is_in_group("TileMapDestruible"):
		var punto_colision = $Area2D.global_position
		golpeado.romper_posicion_global(punto_colision)
		queue_free()
	
func _physics_process(delta: float) -> void:
	var direccion = Vector2.from_angle(rotation)
	position += direccion * 150 * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass
