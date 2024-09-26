extends Area2D

const pre_enemigo = preload("res://Modelos/personaje.tscn")
@export var skin: ListasTexturas.texturas_personaje;
@export var vida: int = 1

func _on_timer_timeout() -> void:
	
	var punto_aleatorio = Vector2(
		randi_range(int(global_position.x) - size().x / 2, int(global_position.x) + size().x / 2),
		randi_range(int(global_position.y) - size().y / 2, int(global_position.y) + size().y / 2)
	)
	
	var enemigo = pre_enemigo.instantiate();
	enemigo.direccion = Vector2(0,1);
	enemigo.skin = skin;
	enemigo.vida = vida;
	enemigo.add_to_group("enemigo")
	get_parent().get_parent().add_child(enemigo);
	enemigo.global_position.x = punto_aleatorio.x;
	enemigo.global_position.y = punto_aleatorio.y;
	
	

func size() -> Vector2:
	return get_node("CollisionShape2D").shape.extents * 2
	
