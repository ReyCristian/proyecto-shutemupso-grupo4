extends AnimationPlayer

@onready var personaje =  $"../.."
@onready var sprite =  $".."

func _process(_delta: float) -> void:
	if personaje.en_demo:
		return;
	if sprite.esta_ocupado() and not sprite.esta_atacando():
		return;
	var direccion = (personaje.direccion + personaje.auto_movimiento)
	
	if direccion == Vector2.ZERO:
		return;
	set_direccion(direccion);

	pass

func angulo_simplificado(angulo_en_grados: int) -> int:
	if (angulo_en_grados % 90 > 0):
		return round(angulo_en_grados / 90) * 90 + 45;
	elif (angulo_en_grados % 90 < 0):
		return round(angulo_en_grados / 90) * 90 - 45;
	else:
		return angulo_en_grados;

func set_direccion(direccion:Vector2):
	var angulo_en_grados = int(rad_to_deg(direccion.angle()));
	apuntar(angulo_en_grados);
	
func apuntar(angulo_en_grados:int):
	match angulo_simplificado(angulo_en_grados):
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
		180:
			self.play("izquierda");
		135:
			self.play("abajo_izquierda");
		_:
			self.play("arriba");
