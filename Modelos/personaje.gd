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

@export var vida: int = 3;
var muerto:bool = false;
var limpiar_cadaver:bool = true;

@onready var magia = $magia;
@onready var espada = $espada;
@onready var hitbox = $hitbox;


func _ready() -> void:
	$Sprite2D/direccion.poner_direccion(direccion);
	if vida <=0:
		$hitbox.morir()

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

func _on_animacion_animation_finished(anim_name: StringName) -> void:
	if en_demo:
		$Sprite2D.visible = true;
		return;
	pass # Replace with function body.

func romper_objeto_de_mapa(golpeado):
	golpeado.romper_posicion_global(global_position + direccion.normalized() * 8)

	
func verificar_si_esta_en_camino_fijo(movimiento:Vector2) -> bool:
	if get_parent() is PathFollow2D:
		seguir_camino(movimiento);
		return true;
	else:
		return false;
