extends CharacterBody2D

var direccion = Vector2.ZERO;
var auto_movimiento = Vector2.ZERO;
var velocidad = 0;

var fase = 1;

var vida = 10;
var fase2 = Callable(self,"_cuando_barra_vida_cargada")
var heroe

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	auto_movimiento = Vector2.UP/4;
	velocidad = 100;
	$jefe_hud/Area_desplazamiento/Timer.start()
	heroe = get_tree().get_first_node_in_group("principal").obtener_heroe()
	$Asiento.objetivo = heroe;
	$inicia_pelea.queue_free()
	$mostrar_barra_vida.queue_free()
	#$Asiento/personaje/Sprite2D.reproducir("casteo_magia")
	
	
func _physics_process(delta: float) -> void:
	#print($jefe_hud/Area_desplazamiento/Timer.time_left)
	#var movimiento = velocidad * direccion * delta;
	direccion = $jefe_hud/Area_desplazamiento/proxima_posicion.global_position - global_position
	if direccion.length()<1:
		direccion = Vector2.ZERO
	position += velocidad * auto_mover(direccion.normalized()) * delta
	#move_and_collide(movimiento)
	
func auto_mover(direccion_normalizada) -> Vector2:
	if direccion_normalizada.x == 0:
		direccion_normalizada.x = auto_movimiento.x;
		
	if direccion_normalizada.y == 0:
		direccion_normalizada.y = auto_movimiento.y;
	return direccion_normalizada;
	
func cambiar_fase(_fase):
	if _fase == 2:
		$jefe_hud/Area_desplazamiento/Timer.stop()
		$jefe_hud/vida.seleccionar_jefe(self);
		$jefe_hud/vida.modulate = "#000000cc"
		$jefe_hud/vida.listo.connect(fase2)
		
func _cuando_area_entra_hitbox(area: Area2D) -> void:
	if fase == 2 and area.get_parent().is_in_group("laser_p"):
		tomar_daño();
		area.get_parent().queue_free();

func tomar_daño():
	if vida <=0 or recibio_daño():
		return;
	vida -=1;
	if vida <=0:
		morir()
	#else:
		#animacion.tomar_daño()
	
func recibio_daño():
	return false;

func morir():
	velocidad = 0
	pass

func _cuando_barra_vida_cargada():
	$fases.play("fase 2");
	fase = 2;
	$laser_fase2_timer.start()
	$jefe_hud/vida.listo.disconnect(fase2)
	$jefe_hud/Area_desplazamiento/Timer.start()


func _cuando_termina_pelea() -> void:
	$jefe_hud/vida.visible = false;
	var  terminar_nivel= preload("res://Herramientas/cinematica_fin_nivel.tscn").instantiate();
	var nivel = get_tree().get_first_node_in_group("nivel");
	nivel.detener()
	nivel.add_child(terminar_nivel);
	terminar_nivel.global_position = Vector2(241,112)
	queue_free()
	pass


func _dispara_laser_fase2() -> void:
	if heroe!=null:
		var laser_dirigido = preload("res://Modelos/laser_dirigido.tscn").instantiate()
		get_parent().add_child(laser_dirigido)
		laser_dirigido.seleccionar_laser(2)
		laser_dirigido.global_position = global_position
		laser_dirigido.marcar_camino(heroe.global_position)
	pass 
