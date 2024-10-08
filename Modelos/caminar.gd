extends Node2D

@onready var personaje = $"..";
@onready var sprite = $"../Sprite2D"


func _physics_process(delta: float) -> void:
	#Si esta en espera no hace nada
	if personaje.esperando || personaje.muerto:
		return;
	var direccion_normalizada = personaje.direccion.normalized();
	var direccion_final = agregar_direccion_automatica(direccion_normalizada);
	var movimiento=calcular_movimiento(direccion_final,delta);
	
	if esta_en_camino_fijo():
		seguir_camino(movimiento);
	else:
		personaje.move_and_collide(movimiento);
	pass;
	
func seguir_camino(movimiento:Vector2):
	var camino = personaje.get_parent();
	camino.progress += movimiento.length();
	#invierto la rotacion porque el nodo path gira al personaje y no le cambia el 
	sprite.rotation = -camino.rotation;
	#en su lugar cambiamos la direccion para que el sprite cambie al de esa direccion
	personaje.direccion = obtener_direccion_camino();
	
func obtener_direccion_camino() -> Vector2:
	var camino = personaje.get_parent();
	#Crea un vector con el angulo del camino y el modulo de la direccion del personaje
	return Vector2.from_angle(camino.rotation) * personaje.direccion.length()

func agregar_direccion_automatica(direccion:Vector2) -> Vector2:
	if esta_chocando():
		return direccion;
	if direccion.x == 0:
		direccion.x = personaje.auto_movimiento.x;
		
	if direccion.y == 0:
		direccion.y = personaje.auto_movimiento.y;
	return direccion;

func esta_chocando():
	return $"../hitbox".get_overlapping_bodies().size() > 1

func calcular_movimiento(direccion: Vector2,delta: float) -> Vector2:
	var movimiento;
	if personaje.isCorriendo:
		movimiento = direccion * personaje.velocidadCorriendo * delta
	elif personaje.dash:
		movimiento = direccion * personaje.velocidadDash * delta
	else:
		movimiento = direccion * personaje.velocidad * delta
		
	return movimiento;
	
func esta_en_camino_fijo() -> bool:
	return personaje.get_parent() is PathFollow2D;
