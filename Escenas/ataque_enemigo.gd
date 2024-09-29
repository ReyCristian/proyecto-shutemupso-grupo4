extends Node

@export var ataque:int = 2;
@export var espera_disparo:float = 2;
@export var direccion: Vector2 = Vector2.DOWN;

func _ready() -> void:
	$Enemigo/Timer.wait_time = espera_disparo;
	

func _physics_process(delta: float) -> void:
	if get_child_count() == 0:
		queue_free()
		return
	$Enemigo.direccion = direccion;
	if $Enemigo.magia_lista:
		$Enemigo.shot(ataque)
		await get_tree().create_timer(0.3).timeout
		if $Enemigo.magia_lista:
			$Enemigo.detener_shot()

func _on_timer_timeout() -> void:
	$Enemigo.preparar_shot()
	pass # Replace with function body.
