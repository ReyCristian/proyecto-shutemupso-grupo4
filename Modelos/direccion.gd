extends AnimationPlayer

@onready var personaje =  $"../.."

func _process(_delta: float) -> void:
	if get_tree().current_scene.name == "personaje":
		return;
	var direccion = (personaje.direccion + personaje.auto_movimiento)
	var angulo_en_grados = int(rad_to_deg(direccion.angle()))
	if direccion == Vector2.ZERO:
		return;
			
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
	pass

func angulo_simplificado(angulo_en_grados: int) -> int:
	if (angulo_en_grados % 90 > 0):
		return round(angulo_en_grados / 90) * 90 + 45;
	elif (angulo_en_grados % 90 < 0):
		return round(angulo_en_grados / 90) * 90 - 45;
	else:
		return angulo_en_grados;
