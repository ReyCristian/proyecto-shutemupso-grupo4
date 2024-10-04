extends Area2D

const pre_enemigo = preload("res://Modelos/personaje.tscn")
@export var skin: ListasTexturas.texturas_personaje;
@export var vida: int = 1
@export var direccion :Vector2 = Vector2(0,1);
@export var isCorriendo :bool = false;
@export var tiene_espada :bool = true;

#Esta funcion es llamada al terminarse el tiempo del timer
func _on_timer_timeout() -> void:
	var punto_aleatorio = obtener_punto_aleatorio_area();
	var enemigo = instanciar_enemigo();
	cargar_configuracion(enemigo);
	get_parent().get_parent().add_child(enemigo);
	posicionar(enemigo,punto_aleatorio);
	
func obtener_punto_aleatorio_area() -> Vector2:
	return Vector2(
		randi_range(int(global_position.x) - tamaño().x / 2, int(global_position.x) + tamaño().x / 2),
		randi_range(int(global_position.y) - tamaño().y / 2, int(global_position.y) + tamaño().y / 2)
	)

func tamaño() -> Vector2:
	return get_node("CollisionShape2D").shape.extents * 2

func instanciar_enemigo() -> CharacterBody2D:
	return pre_enemigo.instantiate();

func cargar_configuracion(enemigo):
	enemigo.direccion = direccion;
	enemigo.skin = skin;
	enemigo.vida = vida;
	enemigo.isCorriendo = isCorriendo;
	enemigo.tiene_espada = tiene_espada;
	enemigo.add_to_group("enemigo")

func posicionar(enemigo:CharacterBody2D,punto_aleatorio:Vector2):
	enemigo.global_position.x = punto_aleatorio.x;
	enemigo.global_position.y = punto_aleatorio.y;
	
