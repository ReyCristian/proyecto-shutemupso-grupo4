extends CharacterBody2D;

@export var velocidad: float = 35.0;
@export var velocidadCorriendo: float = 100.0;
@export var direccion: Vector2 = Vector2.ZERO;
@export var dash: bool = false;
@export var tiene_espada: bool = true;
@export var en_demo:bool = false;

@export var auto_movimiento = Vector2(0,0);

var isCorriendo: bool = false;

@export var esperando: bool  = false;

@export var skin: ListasTexturas.texturas_personaje;

func _physics_process(delta: float) -> void:
	#Si esta en espera no hace nada
	if esperando:
		return;
		
	var direccion_normalizada = self.direccion.normalized();
		
	var movimiento=calcular_movimiento(direccion_normalizada,delta);
		
	move_and_collide(movimiento);
	pass;


func direccion_plano(direccion_normalizada) -> Vector2:
	if get_parent().get("mapa") && get_parent().get_node(get_parent().mapa).isIsometric:
		direccion_normalizada.y = direccion_normalizada.y * 0.5;
		direccion_normalizada = direccion_normalizada.normalized();
	return direccion_normalizada;

func calcular_movimiento(direccion_normalizada: Vector2,delta: float) -> Vector2:
	var movimiento;
	if isCorriendo or dash:
		movimiento = direccion_normalizada * velocidadCorriendo * delta
	else:
		movimiento = direccion_normalizada * velocidad * delta
	
	if dash:
		movimiento *=20;
	return movimiento;

func dar_golpe() -> void:
	if tiene_espada:
		$Sprite2D.dar_golpe_espada();
	else:
		$Sprite2D.dar_golpe();
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if self.is_in_group("enemigo") and body.is_in_group("personaje"):
		$Sprite2D/direccion.set_direccion(body.global_position - global_position)
		dar_golpe();
		
	
	
