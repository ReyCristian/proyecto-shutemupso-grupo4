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

var disparo:bool = true
var pre_laser:Resource = preload("res://Modelos/laser.tscn")
var antena_superior:bool = true

@export var vida: int = 3
var muerto:bool = false;
var limpiar_cadaver:bool = true;

func _ready() -> void:
	if self.is_in_group("enemigo"):
		self.set_collision_layer(2);
		self.set_collision_mask(0);

func _physics_process(delta: float) -> void:
	#Si esta en espera no hace nada
	if esperando || muerto:
		return;
		
	var direccion_normalizada = self.direccion.normalized();
	var direccion_automatica = auto_mover(direccion_normalizada)
	var movimiento=calcular_movimiento(direccion_automatica,delta);
		
	move_and_collide(movimiento);
	pass;


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

func dar_golpe(body: Node2D) -> void:
	if muerto:
		return;
	$Sprite2D/direccion.set_direccion(body.global_position - global_position)
	if tiene_espada:
		$Sprite2D.dar_golpe_espada();
	else:
		$Sprite2D.dar_golpe();

func shot():
	if muerto:
		return;
	if disparo:
		var laser = pre_laser.instantiate()
		get_parent().add_child(laser)
		laser.position.x = position.x + 16
		if antena_superior:
			laser.position.y = position.y - 8
		else:
			laser.position.y = position.y + 8
		#antena_superior = not antena_superior 
		$Sprite2D.shot()
		
		disparo = false
		await get_tree().create_timer(0.5).timeout
		disparo = true

func tomar_daño():
	if muerto:
		return;
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
		
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.

func _on_cuerpo_entra_zona_hostilidad(body: Node2D) -> void:
	if self.is_in_group("enemigo") and body.is_in_group("personaje"):
		dar_golpe(body);


func _on_area_entra_hitbox(area: Area2D) -> void:
	if self.is_in_group("enemigo") and area.is_in_group("laser"):
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
		if golpeado.is_in_group("vivo"):
			golpeado.tomar_daño()
