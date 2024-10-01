extends Sprite2D

var personaje: CharacterBody2D;
var sprite: Sprite2D;

#lista de animaciones para el demo mode
#const animations = ["RESET", "idle", "caminar", "correr","espada","golpe","casteo_magia","magia","arco","daño","muerte"]  
const animations = ["RESET", "idle", "correr","preparar_espada","espada","casteo_magia","magia"]  
const direcciones = ["abajo","arriba","abajo_derecha","izquierda","arriba_derecha","abajo_izquierda","derecha","arriba_izquierda"]
var current_animation = 0;

var timer;

func lanzar(_personaje):
	personaje = _personaje;
	sprite = personaje.get_node("Sprite2D")
	if not personaje.en_demo:
		sprite.scale = Vector2(10,10);
	personaje.en_demo = true;
	timer = Timer.new();
	sprite.add_child(timer);
	timer.wait_time = 3.0 ;
	timer.connect("timeout", Callable(self, "_on_timeout"));
	timer.start();
	_on_timeout();
	pass

# Esta funcion es llamada por el timer demo (se crea en la funcion demo_mode)
func _on_timeout():
	carga_skin_aleatoria_al_terminar_ciclo_animacion();
	sprite.reproducir(dame_animacion_segun_ciclo());
	sprite.get_node("direccion").play(dame_animacion_giro_segun_ciclo());
	siguiente_animacion_ciclo()

func carga_skin_aleatoria_al_terminar_ciclo_animacion():
	if personaje.is_in_group("heroe"):
		return;
	if current_animation % animations.size() == 0 && current_animation > 0:
		personaje.skin = dame_skin_aleatoria()
		sprite.cargar_skin();
		
func dame_skin_aleatoria():
	var indice_aleatorio = randi_range(0, ListasTexturas.texturas_personaje.size() - 1);
	return ListasTexturas.texturas_personaje.values()[indice_aleatorio] ;

func dame_animacion_segun_ciclo():
	return animations[current_animation % animations.size()]
	
func dame_animacion_giro_segun_ciclo():
	return direcciones[current_animation / animations.size()]

func siguiente_animacion_ciclo():
	current_animation = (current_animation + 1) % (animations.size() * direcciones.size());
