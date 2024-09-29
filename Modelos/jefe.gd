extends CharacterBody2D

var direccion = Vector2.ZERO;
@export var velocidad = 25;


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	direccion = Vector2.UP;
	$Asiento/personaje/Sprite2D.reproducir("casteo_magia")
	
	
func _physics_process(delta: float) -> void:
	var movimiento = velocidad * direccion * delta;
	position += velocidad * direccion * delta
	#move_and_collide(movimiento)
