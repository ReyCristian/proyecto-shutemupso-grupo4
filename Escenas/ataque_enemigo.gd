extends Node

@export var ataque:int = 2;
@export var espera_disparo:float = 2;
@export var direccion: Vector2 = Vector2.DOWN;

func _ready() -> void:
	$Enemigo/Timer.wait_time = espera_disparo;
	

func _physics_process(_delta: float) -> void:
	if is_instance_valid($Enemigo):
		$Enemigo.direccion = direccion;
		if $Enemigo.magia_lista:
			$Enemigo.shot(ataque)
			await get_tree().create_timer(0.3).timeout
			if is_instance_valid($Enemigo) and $Enemigo.magia_lista:
				$Enemigo.detener_shot()

func _on_timer_timeout() -> void:
	$Enemigo.preparar_shot()
	pass # Replace with function body.
