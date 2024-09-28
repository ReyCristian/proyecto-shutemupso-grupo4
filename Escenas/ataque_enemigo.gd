extends Node

@export var ataque:int = 1;
@export var espera_disparo:float = 2;

func _ready() -> void:
	$Enemigo/Timer.wait_time = espera_disparo;
	

func _physics_process(delta: float) -> void:
	if $Enemigo.magia_lista:
		$Enemigo.shot(ataque)
		await get_tree().create_timer(0.3).timeout
		$Enemigo.detener_shot()

func _on_timer_timeout() -> void:
	$Enemigo.preparar_shot()
	pass # Replace with function body.
