extends Node2D

@onready var personaje = $"..";
@onready var sprite = $"../Sprite2D"

func _physics_process(delta: float) -> void:
	#Si esta en espera no hace nada
	if personaje.esperando || personaje.muerto:
		return;
	var direccion_normalizada = personaje.direccion.normalized();
	var direccion_automatica = auto_mover(direccion_normalizada);
	var movimiento=calcular_movimiento(direccion_automatica,delta);
	
	if not verificar_si_esta_en_camino_fijo(movimiento):
		personaje.move_and_collide(movimiento);
	pass;
	
func seguir_camino(movimiento:Vector2):
	personaje.get_parent().progress += movimiento.length()
	sprite.rotation = -personaje.get_parent().rotation
	personaje.direccion = obtener_direccion_camino();
	
func obtener_direccion_camino() -> Vector2:
	return Vector2.RIGHT.rotated(personaje.get_parent().rotation) * personaje.direccion.length()

func auto_mover(direccion_normalizada) -> Vector2:
	if esta_chocando():
		return direccion_normalizada;
	if direccion_normalizada.x == 0:
		direccion_normalizada.x = personaje.auto_movimiento.x;
		
	if direccion_normalizada.y == 0:
		direccion_normalizada.y = personaje.auto_movimiento.y;
	return direccion_normalizada;

func esta_chocando():
	return $"../hitbox".get_overlapping_bodies().size() > 1

func calcular_movimiento(direccion_normalizada: Vector2,delta: float) -> Vector2:
	var movimiento;
	if personaje.isCorriendo or personaje.dash:
		movimiento = direccion_normalizada * personaje.velocidadCorriendo * delta
	else:
		movimiento = direccion_normalizada * personaje.velocidad * delta
	
	if personaje.dash:
		movimiento *=20;
	return movimiento;
	
func verificar_si_esta_en_camino_fijo(movimiento:Vector2) -> bool:
	if personaje.get_parent() is PathFollow2D:
		seguir_camino(movimiento);
		return true;
	else:
		return false;
