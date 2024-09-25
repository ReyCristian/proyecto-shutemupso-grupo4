extends CharacterBody2D;

@export var velocidad: float = 35.0;
@export var velocidadCorriendo: float = 300.0;
@export var direccion: Vector2 = Vector2.ZERO;
@export var dash: bool = false;

@onready var reproductor_animaciones:AnimationPlayer = $Sprite2D/Animacion;

@export var auto_movimiento = Vector2(0,0);

var isCorriendo: bool = false;

@export var esperando: bool  = false;

enum lista_texturas {
	CHARACTER_BASE,
	ARCHER_GREEN,
	ARCHER_PURPLE,
	HUMAN_SOLDIER_CYAN,
	HUMAN_SOLDIER_RED,
	HUMAN_WORKER_CYAN,
	HUMAN_WORKER_RED,
	MAGE_CYAN,
	MAGE_RED,
	ORC_GRUNT,
	ORC_PEON_CYAN,
	ORC_PEON_RED,
	ORC_SOLDIER_CYAN,
	ORC_SOLDIER_RED,
	SOLDIER_BLUE,
	SOLDIER_RED,
	SOLDIER_YELLOW,
	WARRIOR_BLUE,
	WARRIOR_RED
}

var skin_texturas = {
	lista_texturas.CHARACTER_BASE: "res://Recursos/personajes/Character-Base.png",
	lista_texturas.ARCHER_GREEN: "res://Recursos/personajes/Archer-Green.png",
	lista_texturas.ARCHER_PURPLE: "res://Recursos/personajes/Archer-Purple.png",
	lista_texturas.HUMAN_SOLDIER_CYAN: "res://Recursos/personajes/Human-Soldier-Cyan.png",
	lista_texturas.HUMAN_SOLDIER_RED: "res://Recursos/personajes/Human-Soldier-Red.png",
	lista_texturas.HUMAN_WORKER_CYAN: "res://Recursos/personajes/Human-Worker-Cyan.png",
	lista_texturas.HUMAN_WORKER_RED: "res://Recursos/personajes/Human-Worker-Red.png",
	lista_texturas.MAGE_CYAN: "res://Recursos/personajes/Mage-Cyan.png",
	lista_texturas.MAGE_RED: "res://Recursos/personajes/Mage-Red.png",
	lista_texturas.ORC_GRUNT: "res://Recursos/personajes/Orc-Grunt.png",
	lista_texturas.ORC_PEON_CYAN: "res://Recursos/personajes/Orc-Peon-Cyan.png",
	lista_texturas.ORC_PEON_RED: "res://Recursos/personajes/Orc-Peon-Red.png",
	lista_texturas.ORC_SOLDIER_CYAN: "res://Recursos/personajes/Orc-Soldier-Cyan.png",
	lista_texturas.ORC_SOLDIER_RED: "res://Recursos/personajes/Orc-Soldier-Red.png",
	lista_texturas.SOLDIER_BLUE: "res://Recursos/personajes/Soldier-Blue.png",
	lista_texturas.SOLDIER_RED: "res://Recursos/personajes/Soldier-Red.png",
	lista_texturas.SOLDIER_YELLOW: "res://Recursos/personajes/Soldier-Yellow.png",
	lista_texturas.WARRIOR_BLUE: "res://Recursos/personajes/Warrior-Blue.png",
	lista_texturas.WARRIOR_RED: "res://Recursos/personajes/Warrior-Red.png"
}

@export var skin: lista_texturas;
func _ready() -> void:
	
	cargar_skin()
	reproductor_animaciones.play("RESET");
	
	#Activa el modo demo, es para pruebas y para el menu
	if get_tree().current_scene.name == "personaje":
		demo_mode();

func _physics_process(delta: float) -> void:
	#Si esta en espera no hace nada
	if esperando:
		return;
		
	
	var direccion_grafica = self.direccion.normalized();
	
	#direccion_grafica = auto_mover(direccion_grafica);
	direccion_grafica = direccion_plano(direccion_grafica);
	
	var movimiento=calcular_movimiento(direccion_grafica,delta);
		
	move_and_collide(movimiento);
	pass;

func auto_mover(direccion_grafica) -> Vector2:
	if direccion_grafica.x == 0:
		direccion_grafica.x = auto_movimiento.x;
		
	if direccion_grafica.y == 0:
		direccion_grafica.y = auto_movimiento.y;
	return direccion_grafica;

func direccion_plano(direccion_grafica) -> Vector2:
	if get_parent().get("mapa") && get_parent().get_node(get_parent().mapa).isIsometric:
		direccion_grafica.y = direccion_grafica.y * 0.5;
		direccion_grafica = direccion_grafica.normalized();
	return direccion_grafica;

func calcular_movimiento(direccion_grafica: Vector2,delta: float) -> Vector2:
	var movimiento;
	if isCorriendo or dash:
		movimiento = direccion_grafica * velocidadCorriendo * delta
	else:
		movimiento = direccion_grafica * velocidad * delta
	
	if dash:
		movimiento *=20;
	return movimiento;

func cargar_skin() -> void:
	if skin != null:
		var textura = load(skin_texturas[skin])
		print(skin_texturas[skin])
		$Sprite2D.texture = textura;
		#Carga las animaciones de la skin
		reproductor_animaciones.active = false;
		reproductor_animaciones = get_animation_player_skin(skin);
		reproductor_animaciones.active = true;

const lista_texturas_animacion2 = [
	lista_texturas.CHARACTER_BASE,
	lista_texturas.ARCHER_GREEN,
	lista_texturas.ARCHER_PURPLE,
	lista_texturas.SOLDIER_YELLOW,
	lista_texturas.SOLDIER_BLUE,
	lista_texturas.SOLDIER_RED,
	lista_texturas.WARRIOR_BLUE,
	lista_texturas.WARRIOR_RED,
	lista_texturas.MAGE_CYAN,
	lista_texturas.MAGE_RED
	];

func get_animation_player_skin(skin:lista_texturas) -> AnimationPlayer:
	if (skin in lista_texturas_animacion2):
		print("$Sprite2D/Animacion2")
		return $Sprite2D/Animacion2;
	else:
		print("$Sprite2D/Animacion")
		return $Sprite2D/Animacion;
	

const animations = ["RESET", "idle", "caminar", "correr","espada","golpe","casteo_magia","magia","arco","daño","muerte"]  
const direcciones = ["abajo","arriba","abajo_derecha","izquierda","arriba_derecha","abajo_izquierda","derecha","arriba_izquierda"]
var current_animation = 0;


func demo_mode():
	scale.x=10;
	scale.y=10;
	var timer = Timer.new();
	add_child(timer);
	timer.wait_time = 3.0 ;
	timer.connect("timeout", Callable(self, "_on_timeout"));
	timer.start();
	_on_timeout();
	pass

func _on_timeout():
	if current_animation % animations.size() == 0 && current_animation > 0:
		skin = get_skin_aleatoria()
		cargar_skin();
	reproductor_animaciones.play(animations[current_animation % animations.size()]);
	$Sprite2D/direccion.play(direcciones[current_animation / animations.size()]);
	current_animation = (current_animation + 1) % (animations.size() * direcciones.size());

func get_skin_aleatoria():
	var indice_aleatorio = randi_range(0, lista_texturas.size() - 1);
	return lista_texturas.values()[indice_aleatorio] ;
