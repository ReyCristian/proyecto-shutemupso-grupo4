extends CharacterBody2D;

@export var velocidad: float = 35.0;
@export var velocidadCorriendo: float = 100.0;
@export var velocidadDash: float = 2000.0;
@export var direccion: Vector2 = Vector2.ZERO;

@export var auto_movimiento = Vector2(0,0);
@export var auto_apuntado :float = 360;


@export var isCorriendo: bool = false;
@export var dash: bool = false;
@export var esperando: bool  = false;
@export var en_demo:bool = false;

@export var skin: ListasTexturas.texturas_personaje;
@export var tiene_espada: bool = true;

@export var vida: int = 3;
var muerto:bool = false;
var limpiar_cadaver:bool = true;

@onready var magia = $magia;
@onready var espada = $espada;
@onready var hitbox = $hitbox;
@onready var sprite = $Sprite2D;
@onready var caminar = $Caminar;



func _ready() -> void:
	$Sprite2D/direccion.poner_direccion(direccion);
	if vida <=0:
		$hitbox.morir()

func _on_animacion_animation_finished(_anim_name: StringName) -> void:
	if en_demo:
		$Sprite2D.visible = true;
		return;
	pass # Replace with function body.

func romper_objeto_de_mapa(golpeado):
	golpeado.romper_posicion_global(global_position + direccion.normalized() * 8)
