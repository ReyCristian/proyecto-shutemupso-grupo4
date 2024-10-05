extends Node

@export var ataque:int = 2;
@export var espera_disparo:float = 2;
@export var direccion: Vector2 = Vector2.DOWN;
@export var objetivo: Node2D; 

func _ready() -> void:
	$Enemigo/Timer.wait_time = espera_disparo;
	_on_timer_timeout()
	

func _physics_process(_delta: float) -> void:	
	if not has_node("Enemigo") or not is_instance_valid($Enemigo):
		get_parent().cambiar_fase(2);
		queue_free()
		return
	if objetivo != null and is_instance_valid(objetivo):
		direccion = objetivo.global_position - $Enemigo.global_position 

	$Enemigo.direccion = direccion;
	if $Enemigo.magia.magia_lista:
		$Enemigo.magia.shot(ataque)
		await get_tree().create_timer(0.3).timeout
		if is_instance_valid($Enemigo) and $Enemigo.magia.magia_lista:
			$Enemigo.magia.detener_shot()

func _on_timer_timeout() -> void:
	$Enemigo.magia.preparar_shot()
	pass # Replace with function body.
