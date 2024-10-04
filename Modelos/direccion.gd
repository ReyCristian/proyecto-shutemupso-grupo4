extends AnimationPlayer

@onready var personaje =  $"../.."
@onready var sprite =  $".."

var angulo : int = 0;

func _process(_delta: float) -> void:
	if personaje.en_demo:
		return;
	if sprite.esta_ocupado() and not sprite.esta_preparando_ataque():
		return;
	if sprite.esta_atacando():
		return;
	var direccion = (personaje.direccion + personaje.auto_movimiento)
	if direccion == Vector2.ZERO:
		return;
	poner_direccion(direccion);
	pass

func obtener_angulo() -> int:
	if angulo == -180:
		angulo = 180
	return angulo

func angulo_simplificado(angulo_en_grados: float) -> int:
	return round(angulo_en_grados / 45) * 45
	

func poner_direccion(direccion:Vector2):
	if es_slime():
		return;
	var angulo_en_radianes = direccion.angle();
	var angulo_en_grados = int(rad_to_deg(angulo_en_radianes));
	apuntar(angulo_en_grados);
	
func apuntar(angulo_en_grados:int):
	angulo = angulo_simplificado(angulo_en_grados)
	match angulo:
		90:
			self.play("abajo");
		45:
			self.play("abajo_derecha");
		0:
			self.play("derecha");
		-45:
			self.play("arriba_derecha");
		-90:
			self.play("arriba");
		-135:
			self.play("arriba_izquierda");
		180,-180:
			self.play("izquierda");
		135:
			self.play("abajo_izquierda");
		_:
			self.play("arriba");

func auto_apuntar(angulo_en_grados:int):
	var angulo_en_radianes = deg_to_rad(angulo_en_grados)
	var direccion_de_auto_apuntado = Vector2.RIGHT.rotated(angulo_en_radianes)
	var resultante = direccion_de_auto_apuntado + personaje.direccion
	var nuevo_angulo_en_radianes = resultante.angle()
	var nuevo_angulo_en_grados = rad_to_deg(nuevo_angulo_en_radianes)
	apuntar(nuevo_angulo_en_grados);

func es_slime() -> bool:
	return personaje.skin == ListasTexturas.texturas_personaje.SLIME;
