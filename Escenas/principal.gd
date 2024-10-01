extends Node2D

const pre_fondo_menu:PackedScene = preload("res://Escenas/Menu/fondo_menu.tscn");
var lvl_actual: Node2D = null; 

func _ready() -> void:
	$Menu_Hub/Menu/Niveles/Control.cargar_lvl(pre_fondo_menu);
	pass

func ver_pantalla_inicio_nivel():
	$InicioNivel.ver_pantalla_inicio_nivel();

func detener_pantalla_inicio_nivel():
	$InicioNivel.detener();

func derrota():
	$InicioNivel.ver_pantalla_derrota();

func reiniciar_nivel():
	var escena = lvl_actual.get("archivo_escena")
	remove_child(lvl_actual)
	lvl_actual.queue_free()
	lvl_actual = escena.instantiate() as Node2D
	lvl_actual.set("archivo_escena",escena);
	add_child(lvl_actual)
