extends Sprite2D

@onready var personaje = $"..";
@onready var reproductor_animaciones:AnimationPlayer = $Animacion;

func _ready() -> void:
	cargar_skin()
	reproductor_animaciones.play("RESET");
	
	#Activa el modo demo, es para pruebas y para el menu
	if get_tree().current_scene.name == "personaje":
		demo_mode();

var skin_texturas = {
	ListasTexturas.texturas_personaje.CHARACTER_BASE: "res://Recursos/personajes/Character-Base.png",
	ListasTexturas.texturas_personaje.ARCHER_GREEN: "res://Recursos/personajes/Archer-Green.png",
	ListasTexturas.texturas_personaje.ARCHER_PURPLE: "res://Recursos/personajes/Archer-Purple.png",
	ListasTexturas.texturas_personaje.HUMAN_SOLDIER_CYAN: "res://Recursos/personajes/Human-Soldier-Cyan.png",
	ListasTexturas.texturas_personaje.HUMAN_SOLDIER_RED: "res://Recursos/personajes/Human-Soldier-Red.png",
	ListasTexturas.texturas_personaje.HUMAN_WORKER_CYAN: "res://Recursos/personajes/Human-Worker-Cyan.png",
	ListasTexturas.texturas_personaje.HUMAN_WORKER_RED: "res://Recursos/personajes/Human-Worker-Red.png",
	ListasTexturas.texturas_personaje.MAGE_CYAN: "res://Recursos/personajes/Mage-Cyan.png",
	ListasTexturas.texturas_personaje.MAGE_RED: "res://Recursos/personajes/Mage-Red.png",
	ListasTexturas.texturas_personaje.ORC_GRUNT: "res://Recursos/personajes/Orc-Grunt.png",
	ListasTexturas.texturas_personaje.ORC_PEON_CYAN: "res://Recursos/personajes/Orc-Peon-Cyan.png",
	ListasTexturas.texturas_personaje.ORC_PEON_RED: "res://Recursos/personajes/Orc-Peon-Red.png",
	ListasTexturas.texturas_personaje.ORC_SOLDIER_CYAN: "res://Recursos/personajes/Orc-Soldier-Cyan.png",
	ListasTexturas.texturas_personaje.ORC_SOLDIER_RED: "res://Recursos/personajes/Orc-Soldier-Red.png",
	ListasTexturas.texturas_personaje.SOLDIER_BLUE: "res://Recursos/personajes/Soldier-Blue.png",
	ListasTexturas.texturas_personaje.SOLDIER_RED: "res://Recursos/personajes/Soldier-Red.png",
	ListasTexturas.texturas_personaje.SOLDIER_YELLOW: "res://Recursos/personajes/Soldier-Yellow.png",
	ListasTexturas.texturas_personaje.WARRIOR_BLUE: "res://Recursos/personajes/Warrior-Blue.png",
	ListasTexturas.texturas_personaje.WARRIOR_RED: "res://Recursos/personajes/Warrior-Red.png"
}

func cargar_skin() -> void:
	if personaje.skin != null:
		texture = load(skin_texturas[personaje.skin])
		#Carga las animaciones de la skin
		reproductor_animaciones.active = false;
		reproductor_animaciones = get_animation_player_skin();
		reproductor_animaciones.active = true;

const lista_texturas_animacion2 = [
	ListasTexturas.texturas_personaje.CHARACTER_BASE,
	ListasTexturas.texturas_personaje.ARCHER_GREEN,
	ListasTexturas.texturas_personaje.ARCHER_PURPLE,
	ListasTexturas.texturas_personaje.SOLDIER_YELLOW,
	ListasTexturas.texturas_personaje.SOLDIER_BLUE,
	ListasTexturas.texturas_personaje.SOLDIER_RED,
	ListasTexturas.texturas_personaje.WARRIOR_BLUE,
	ListasTexturas.texturas_personaje.WARRIOR_RED,
	ListasTexturas.texturas_personaje.MAGE_CYAN,
	ListasTexturas.texturas_personaje.MAGE_RED
	];

func get_animation_player_skin() -> AnimationPlayer:
	if (personaje.skin in lista_texturas_animacion2):
		return $Animacion2;
	else:
		return $Animacion;
	

const animations = ["RESET", "idle", "caminar", "correr","espada","golpe","casteo_magia","magia","arco","daño","muerte"]  
const direcciones = ["abajo","arriba","abajo_derecha","izquierda","arriba_derecha","abajo_izquierda","derecha","arriba_izquierda"]
var current_animation = 0;


func demo_mode():
	personaje.en_demo = true;
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
		personaje.skin = get_skin_aleatoria()
		cargar_skin();
	reproducir(animations[current_animation % animations.size()]);
	$direccion.play(direcciones[current_animation / animations.size()]);
	current_animation = (current_animation + 1) % (animations.size() * direcciones.size());

func get_skin_aleatoria():
	var indice_aleatorio = randi_range(0, ListasTexturas.texturas_personaje.size() - 1);
	return ListasTexturas.texturas_personaje.values()[indice_aleatorio] ;

func reproducir(animacion: String):
	reproductor_animaciones.play(animacion);

func dar_golpe():
	reproductor_animaciones.play("golpe");
	
func dar_golpe_espada():
	reproductor_animaciones.play("espada");
