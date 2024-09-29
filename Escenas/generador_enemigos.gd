extends Area2D

const pre_enemigo = preload("res://Modelos/personaje.tscn")
@export var skin: ListasTexturas.texturas_personaje;
@export var vida: int = 1
@export var direccion :Vector2 = Vector2(0,1);
@export var isCorriendo :bool = false;
@export var tiene_espada :bool = true;

func _on_timer_timeout() -> void:
	
	var punto_aleatorio = Vector2(
		randi_range(int(global_position.x) - size().x / 2, int(global_position.x) + size().x / 2),
		randi_range(int(global_position.y) - size().y / 2, int(global_position.y) + size().y / 2)
	)
	
	var enemigo = pre_enemigo.instantiate();
	enemigo.direccion = direccion;
	enemigo.skin = skin;
	enemigo.vida = vida;
	enemigo.isCorriendo = isCorriendo;
	enemigo.tiene_espada = tiene_espada;
	enemigo.add_to_group("enemigo")
	get_parent().get_parent().add_child(enemigo);
	enemigo.global_position.x = punto_aleatorio.x;
	enemigo.global_position.y = punto_aleatorio.y;
	
	

func size() -> Vector2:
	return get_node("CollisionShape2D").shape.extents * 2
	
