extends Control;

@export var personaje_principal: NodePath;

@export var isCorriendo: bool = false;

@onready var personaje = get_node(personaje_principal);

func _physics_process(_delta: float) -> void:
	if personaje:
		reset()
		check_movimiento();
		check_corriendo();
		check_golpe();
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
		personaje.dar_golpe()
