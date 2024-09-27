extends Control;

@export var personaje_principal: NodePath;
@export var mapa_nivel: NodePath;

@export var isCorriendo: bool = false;

@onready var personaje = get_node(personaje_principal);
@onready var mapa = get_node(mapa_nivel);

func _ready() -> void:
	load_movimiento_automatico()
	pass
	
func _physics_process(_delta: float) -> void:
	if personaje and not personaje.muerto:
		reset()
		check_movimiento();
		check_corriendo();
		check_golpe();
		check_shot()
	pass;


func reset():
	personaje.direccion = Vector2.ZERO;

func check_movimiento():
	if Input.is_action_pressed("ui_down"):
		personaje.direccion.y = 1;
	if Input.is_action_pressed("ui_up"):
		personaje.direccion.y = -1;
	if Input.is_action_pressed("ui_left"):
		personaje.direccion.x = -1;
	if Input.is_action_pressed("ui_right"):
		personaje.direccion.x = 1;

func check_corriendo():
	personaje.isCorriendo = isCorriendo or Input.is_action_pressed("correr");
	#personaje.dash = Input.is_action_just_pressed("dash");

func check_golpe():
	if Input.is_action_just_pressed("ui_accept"):
		personaje.dar_golpe();

func check_shot():	
	if Input.is_action_just_pressed("ataque1"):
		personaje.preparar_shot();
		personaje.auto_movimiento = Vector2.ZERO
	if Input.is_action_pressed("ataque1"):
		personaje.shot();
	if Input.is_action_just_released("ataque1"):
		personaje.detener_shot();
		load_movimiento_automatico()
		
func load_movimiento_automatico():
	personaje.auto_movimiento.y = -float(mapa.velocidad) / 100
