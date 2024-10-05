extends Node2D

const pre_fondo_menu:PackedScene = preload("res://Escenas/Menu/fondo_menu.tscn");
var lvl_actual: Node2D = null;


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ayuda"):
		ver_pantalla_inicio_nivel($Menu_Hub/Menu/Niveles/Control.nivel_actual_indice);

func _ready() -> void:
	$Menu_Hub/Menu/Niveles/Control.cargar_lvl(pre_fondo_menu);
	pass

func ver_pantalla_inicio_nivel(nivel:int):
	$InicioNivel.ver_pantalla_inicio_nivel(nivel);

func detener_pantalla_inicio_nivel():
	$InicioNivel.detener();

func derrota():
	var puntaje = obtener_contador_puntaje();
	var referencia = obtener_referencia_puntaje()
	$InicioNivel.ver_pantalla_derrota(puntaje,referencia);

func reiniciar_nivel():
	var escena = lvl_actual.get("archivo_escena")
	remove_child(lvl_actual)
	lvl_actual.queue_free()
	lvl_actual = escena.instantiate() as Node2D
	lvl_actual.set("archivo_escena",escena);
	add_child(lvl_actual)
	

func siguiente_nivel():
	var puntaje = obtener_contador_puntaje();
	var referencia = obtener_referencia_puntaje()
	$Menu_Hub/Menu/Niveles/Control.siguiente_nivel();
	$InicioNivel.ver_pantalla_puntaje(puntaje,referencia,$Menu_Hub/Menu/Niveles/Control.nivel_actual_indice);
	
func obtener_heroe():
	var nivel = get_tree().get_first_node_in_group("nivel")
	var Heroes = get_tree().get_nodes_in_group("heroe")
	for heroe in Heroes:
		if nivel.is_ancestor_of(heroe):
			return heroe;
			
func obtener_contador_puntaje():
	return obtener_nodo_puntaje().contador

func obtener_referencia_puntaje():
	return obtener_nodo_puntaje().puntaje

func obtener_nodo_puntaje() -> Node2D:
	var heroe = obtener_heroe();
	if heroe == null:
		return null;
	return heroe.get_node("puntaje");

func _on_enemigo_muere(skin: ListasTexturas.texturas_personaje) -> void:
	obtener_nodo_puntaje()._on_enemigo_muere(skin)
	
func _on_obstaculo_roto(id) -> void:
	obtener_nodo_puntaje()._on_obstaculo_roto(id)

func final_del_juego():
	var creditos = preload("res://Escenas/creditos 1.tscn").instantiate();
	get_tree().current_scene.add_child(creditos);
	$Menu_Hub/Menu/Principal.esta_abierto = true
	
