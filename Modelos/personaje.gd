extends CharacterBody2D;

@export var velocidad: float = 35.0;
@export var velocidadCorriendo: float = 100.0;
@export var direccion: Vector2 = Vector2.ZERO;
@export var dash: bool = false;
@export var tiene_espada: bool = true;
@export var en_demo:bool = false;

@export var auto_movimiento = Vector2(0,0);

@export var isCorriendo: bool = false;
@export var esperando: bool  = false;
@export var skin: ListasTexturas.texturas_personaje;

var disparo:bool = true;
var magia_lista:bool = false;
var pre_laser:Resource = preload("res://Modelos/laser.tscn");
var antena_superior:bool = true;

@export var vida: int = 3;
var muerto:bool = false;
var limpiar_cadaver:bool = true;

func _ready() -> void:		
	if self.is_in_group("enemigo"):
		self.set_collision_layer(1);
		self.set_collision_mask(0);
		
	guardar_antenas_disparo();
	

func _physics_process(delta: float) -> void:
	#Si esta en espera no hace nada
	if esperando || muerto:
		return;
		
	var direccion_normalizada = self.direccion.normalized();
	var direccion_automatica = auto_mover(direccion_normalizada);
	var movimiento=calcular_movimiento(direccion_automatica,delta);
		
	if get_parent() is PathFollow2D:
		seguir_camino(movimiento);
	else:
		move_and_collide(movimiento);
	pass;
	
func seguir_camino(movimiento:Vector2):
	get_parent().progress += movimiento.length()
	$Sprite2D.rotation = -get_parent().rotation
	direccion = Vector2.RIGHT.rotated(get_parent().rotation) * direccion.length()

func auto_mover(direccion_normalizada) -> Vector2:
	if direccion_normalizada.x == 0:
		direccion_normalizada.x = auto_movimiento.x;
		
	if direccion_normalizada.y == 0:
		direccion_normalizada.y = auto_movimiento.y;
	return direccion_normalizada;

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
		$Sprite2D/direccion.set_direccion(body.global_position - global_position)
	if tiene_espada:
		$Sprite2D.dar_golpe_espada();
	else:
		$Sprite2D.dar_golpe();

func shot(ataque: int = 1):
	if muerto or recibio_daño():
		return;
	if disparo and magia_lista:
		var laser = pre_laser.instantiate()
		get_parent().add_child(laser)
		var antena = get_antena_disparo($Sprite2D/direccion.get_angulo())
		if is_in_group("personaje"):
			laser.add_to_group("laser_p")
		laser.global_position = antena.global_position
		laser.rotation = antena.rotation 
		disparo = false
		await get_tree().create_timer(0 if ataque==1 else 0.5).timeout
		disparo = true

func preparar_shot(ataque: int = 1):
	if muerto or recibio_daño():
		return
	$Sprite2D.shot(ataque)

func set_magia_lista():
	magia_lista = true;

func detener_shot():
	if not (muerto or recibio_daño()):
		$Sprite2D.detener_shot();
		magia_lista = false;

var antenas_disparo = {}

func guardar_antenas_disparo():
	for antena in $antenas_disparo.get_children():
		antenas_disparo[int(round(antena.rotation_degrees))] = antena
		
func get_antena_disparo(angulo_deg: int) -> Node2D:
	return antenas_disparo[angulo_deg];

func get_antena_disparo_cercana(angulo_deg: int) -> Node2D:
	var antena_cercana = $"antenas_disparo/Antena 1"
	var diferencia_minima = 25
	for angulo in antenas_disparo.keys():
		var diferencia = abs(angulo - angulo_deg)
		if diferencia < diferencia_minima:
			diferencia_minima = diferencia
			antena_cercana = antenas_disparo[angulo]
	return antena_cercana

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
	muerto = true;
	$Sprite2D.morir();
	$hitbox.queue_free();
	$hostilidad.queue_free();
	$CollisionShape2D.queue_free();
	
func recibio_daño() -> bool:
	return $Sprite2D.recibio_daño()
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.

func _on_cuerpo_entra_zona_hostilidad(body: Node2D) -> void:
	if self.is_in_group("enemigo") and body.is_in_group("personaje"):
		dar_golpe(body);


func _on_area_entra_hitbox(area: Area2D) -> void:
	if area.is_in_group("laser"):
		tomar_daño();
		area.get_parent().queue_free();


func _on_animacion_animation_finished(anim_name: StringName) -> void:
	if en_demo:
		return;
	if anim_name == "muerte" and muerto and limpiar_cadaver:
		queue_free()
	pass # Replace with function body.

func hacer_daño():
	for golpeado in $area_espada.get_overlapping_bodies():
		if golpeado.is_in_group("vivo") and golpeado != self:
			golpeado.tomar_daño()
		if golpeado.is_in_group("TileMapDestruible"):
			golpeado.romper_posicion_global(global_position + direccion.normalized() * 8)
