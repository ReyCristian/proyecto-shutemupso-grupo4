extends Sprite2D

@onready var personaje = $"..";
@onready var reproductor_animaciones:AnimationPlayer = $Animacion;

var demo_mode = preload("res://Modelos/demo_mode.gd").new()

func _ready() -> void:	
	cargar_skin()
	reproductor_animaciones.play("RESET");
	verificar_modo_demo()

func cargar_skin() -> void:
	if personaje.skin != null:
		texture = load(ListasTexturas.skin_texturas[personaje.skin])
		#Carga las animaciones de la skin
		$Animacion.active = false;
		$Animacion2.active = false;
		$Animacion3.active = false;
		reproductor_animaciones = obtener_reproductor_animaciones_por_skin();
		reproductor_animaciones.active = true;

func obtener_reproductor_animaciones_por_skin() -> AnimationPlayer:
	if (personaje.skin in ListasTexturas.lista_texturas_animacion2):
		return $Animacion2;
	elif (personaje.skin in ListasTexturas.lista_texturas_animacion3):
		return $Animacion3;
	else :
		return $Animacion;

func reproducir(animacion: String):
	if reproductor_animaciones.current_animation != animacion:
		reproductor_animaciones.play("RESET");
	reproductor_animaciones.play(animacion);
	
func agregar_lista_reproduccion(animacion: String):
	reproductor_animaciones.queue(animacion);

func dar_golpe():
	reproducir("golpe");
	
func preparar_golpe_espada():
	reproducir("preparar_espada");

func golpe_preparado() -> bool:
	return reproductor_animaciones.current_animation in ["golpe","preparar_espada"];
	
func dar_golpe_espada():
	reproducir("espada");

func shot(ataque: int = 1) -> void:
	if not esta_preparando_ataque():
		if ataque == 1:
			reproducir("casteo_magia");
			agregar_lista_reproduccion("magia");
		else:
			reproducir("magia");

func esta_preparando_ataque() -> bool:
	return reproductor_animaciones.current_animation in ["magia","casteo_magia"];

func esta_atacando() -> bool:
	return personaje.magia_lista and not personaje.magia_lanzada

func detener_shot() -> void:
	reproducir("RESET")

func tomar_daño():
	reproducir("daño");

func recibio_daño() -> bool:
	return reproductor_animaciones.current_animation in ["daño","muerte"]

func morir():
	reproducir("muerte");
	
func esta_ocupado() -> bool:
	return reproductor_animaciones.esta_ocupado()

func verificar_modo_demo() -> void:
	if get_tree().current_scene.name == "personaje" or personaje.en_demo and personaje.vida > 0:
		demo_mode.lanzar(personaje);
