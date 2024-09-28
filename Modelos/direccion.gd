extends AnimationPlayer

@onready var personaje =  $"../.."
@onready var sprite =  $".."

var angulo : int = 0;

func _process(_delta: float) -> void:
	if personaje.en_demo:
		return;
	if sprite.esta_ocupado() and not sprite.esta_preparando_ataque() or sprite.esta_atacando():
		return;
	var direccion = (personaje.direccion + personaje.auto_movimiento)
	
	if direccion == Vector2.ZERO:
		return;
	set_direccion(direccion);
	pass

func get_angulo() -> int:
	if angulo == -180:
		angulo = 180
	return angulo

func angulo_simplificado(angulo_en_grados: float) -> int:
	return round(angulo_en_grados / 45) * 45
	

func set_direccion(direccion:Vector2):
	if personaje.skin == ListasTexturas.texturas_personaje.SLIME:
		return
	var angulo_en_grados = int(rad_to_deg(direccion.angle()));
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
	var resultante = Vector2.RIGHT.rotated(deg_to_rad(angulo_en_grados)) + personaje.direccion
	apuntar(rad_to_deg(resultante.angle()));
