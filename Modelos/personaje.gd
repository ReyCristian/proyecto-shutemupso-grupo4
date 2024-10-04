extends CharacterBody2D;

@export var velocidad: float = 35.0;
@export var velocidadCorriendo: float = 100.0;
@export var direccion: Vector2 = Vector2.ZERO;
@export var dash: bool = false;
@export var tiene_espada: bool = true;
@export var en_demo:bool = false;

@export var auto_movimiento = Vector2(0,0);
@export var auto_apuntado :float = 360;


@export var isCorriendo: bool = false;
@export var esperando: bool  = false;
@export var skin: ListasTexturas.texturas_personaje;

var disparo:bool = true;
var magia_lista:bool = false;
var magia_lanzada:bool = false;
var pre_laser:Resource = preload("res://Modelos/laser.tscn");

@export var vida: int = 3;
var muerto:bool = false;
var limpiar_cadaver:bool = true;

signal muerte;

func _ready() -> void:
	deshabilitar_colisiones_enemigo();
	conectar_puntaje_enemigos();
	guardar_puntos_disparo();
	$Sprite2D/direccion.poner_direccion(direccion);
	if vida <=0:
		morir()

func _physics_process(delta: float) -> void:
	#Si esta en espera no hace nada
	if esperando || muerto:
		return;
	var direccion_normalizada = self.direccion.normalized();
	var direccion_automatica = auto_mover(direccion_normalizada);
	var movimiento=calcular_movimiento(direccion_automatica,delta);
	
	if not verificar_si_esta_en_camino_fijo(movimiento):
		move_and_collide(movimiento);
	pass;
	
func seguir_camino(movimiento:Vector2):
	get_parent().progress += movimiento.length()
	$Sprite2D.rotation = -get_parent().rotation
	direccion = obtener_direccion_camino();
	
func obtener_direccion_camino() -> Vector2:
	return Vector2.RIGHT.rotated(get_parent().rotation) * direccion.length()

func auto_mover(direccion_normalizada) -> Vector2:
	if esta_chocando():
		return direccion_normalizada;
	if direccion_normalizada.x == 0:
		direccion_normalizada.x = auto_movimiento.x;
		
	if direccion_normalizada.y == 0:
		direccion_normalizada.y = auto_movimiento.y;
	return direccion_normalizada;

func esta_chocando():
	return $hitbox.get_overlapping_bodies().size() > 1

func calcular_movimiento(direccion_normalizada: Vector2,delta: float) -> Vector2:
	var movimiento;
	if isCorriendo or dash:
		movimiento = direccion_normalizada * velocidadCorriendo * delta
	else:
		movimiento = direccion_normalizada * velocidad * delta
	
	if dash:
		movimiento *=20;
	return movimiento;

func dar_golpe(body: Node2D = null) -> void:
	if muerto or recibio_daño():
		return;
	if body!=null:
		$Sprite2D/direccion.poner_direccion(body.global_position - global_position)
	if tiene_espada:
		$Sprite2D.preparar_golpe_espada();
	else:
		$Sprite2D.dar_golpe();

func dar_golpe_espada():
	$Sprite2D.dar_golpe_espada();

#Esta funcion se llama desde el controlador del personaje
func preparar_shot(ataque: int = 1):
	if muerto or recibio_daño():
		return
	auto_apuntar()
	$Sprite2D.shot(ataque)

#Esta funcion la llama la animacion cuando esta lista para lanzar poderes
func set_magia_lista():
	magia_lista = true;

func shot(ataque: int = 1):
	if muerto or recibio_daño():
		return;
	if disparo and magia_lista:
		magia_lanzada = false;
		auto_apuntar()
		var laser = pre_laser.instantiate()
		get_tree().get_nodes_in_group("nivel")[0].add_child(laser)
		var origen_disparo = obtener_origen_disparo($Sprite2D/direccion.obtener_angulo())
		if is_in_group("heroe"):
			laser.add_to_group("laser_p")
		else:
			laser.seleccionar_laser(2);
		laser.global_position = origen_disparo.global_position
		if auto_apuntado == 360:
			laser.rotation = origen_disparo.rotation 
		else:
			laser.rotation = deg_to_rad(auto_apuntado);
		disparo = false
		await get_tree().create_timer(0.0 if ataque==1 else 0.5).timeout
		disparo = true
	
func set_magia_lanzada():
	magia_lanzada = true;

func detener_shot():
	if not (muerto or recibio_daño()):
		$Sprite2D.detener_shot();
		magia_lista = false;

var puntos_disparo = {}

func guardar_puntos_disparo():
	for origen_disparo in $puntos_disparo.get_children():
		puntos_disparo[int(round(origen_disparo.rotation_degrees))] = origen_disparo
		
func obtener_origen_disparo(angulo_deg: int) -> Node2D:
	return puntos_disparo[angulo_deg];

func obtener_punto_disparo_cercano(angulo_deg: int) -> Node2D:
	var punto_disparo_cercano = $"puntos_disparo/Punto 1"
	var diferencia_minima = 25
	for angulo in puntos_disparo.keys():
		var diferencia = abs(angulo - angulo_deg)
		if diferencia < diferencia_minima:
			diferencia_minima = diferencia
			punto_disparo_cercano = puntos_disparo[angulo]
	return punto_disparo_cercano

func tomar_daño():
	if muerto or recibio_daño():
		return;
	magia_lista = false
	vida -=1;
	if vida <=0:
		morir()
	else:
		$Sprite2D.tomar_daño()

func morir():
	if muerto:
		return;
	muerto = true;
	$Sprite2D.morir();
	if is_in_group("enemigo"):
		emit_signal("muerte",skin)
	if not en_demo:
		$hitbox.queue_free();
		$hostilidad.queue_free();
		$CollisionShape2D.queue_free();
	
func recibio_daño() -> bool:
	return $Sprite2D.recibio_daño()
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	if is_in_group("demo") or en_demo:
		return
	if is_in_group("heroe"):
		morir();
		return
	queue_free();
	liberar_padre();

func _on_cuerpo_entra_zona_hostilidad(body: Node2D) -> void:
	if self.is_in_group("enemigo") and body.is_in_group("heroe"):
		dar_golpe(body);


func _on_area_entra_hitbox(area: Area2D) -> void:
	if area.is_in_group("laser") and not (area.get_parent().is_in_group("laser_p") and self.is_in_group("heroe")):
		tomar_daño();
		area.get_parent().queue_free();


func _on_animacion_animation_finished(anim_name: StringName) -> void:
	if en_demo:
		$Sprite2D.visible = true;
		return;
	if anim_name == "muerte" and muerto and limpiar_cadaver:
		queue_free()
		liberar_padre()
		if is_in_group("heroe"):
			get_tree().get_nodes_in_group("principal")[0].derrota();
	pass # Replace with function body.

func liberar_padre():
	var parent = get_parent()
	while parent != null:
		if parent.is_in_group("liberar_al_morir"):
			parent.queue_free()
			break
		parent = parent.get_parent()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if self.is_in_group("enemigo") and body.is_in_group("heroe") and $Sprite2D.golpe_preparado() and not tiene_espada:
		hacer_daño();

func _on_area_espada_body_entered_o_exited(body: Node2D) -> void:
	if self.is_in_group("enemigo") and body.is_in_group("heroe") and $Sprite2D.golpe_preparado() and tiene_espada:
		dar_golpe_espada();

func hacer_daño():
	var golpeados = obtener_cuerpos_en_rango();
	for golpeado in golpeados:
		if golpeado.is_in_group("vivo") and golpeado != self:
			golpeado.tomar_daño()
		if golpeado.is_in_group("TileMapDestruible"):
			romper_objeto_de_mapa(golpeado);

func obtener_cuerpos_en_rango(): 
	if tiene_espada:
		return $area_espada.get_overlapping_bodies()
	else:
		return $hitbox.get_overlapping_bodies()

func romper_objeto_de_mapa(golpeado):
	golpeado.romper_posicion_global(global_position + direccion.normalized() * 8)

func auto_apuntar():
	if auto_apuntado != 360:
		$Sprite2D/direccion.auto_apuntar(auto_apuntado)
	pass

func deshabilitar_colisiones_enemigo():
	if self.is_in_group("enemigo"):
		self.set_collision_layer(1);
		self.set_collision_mask(0);

func conectar_puntaje_enemigos():
	if get_tree().get_nodes_in_group("principal").size() > 0:
		var principal = get_tree().get_nodes_in_group("principal")[0]
		if principal != null: 
			connect("muerte",Callable(principal,"_on_enemigo_muere"))
	
func verificar_si_esta_en_camino_fijo(movimiento:Vector2) -> bool:
	if get_parent() is PathFollow2D:
		seguir_camino(movimiento);
		return true;
	else:
		return false;
