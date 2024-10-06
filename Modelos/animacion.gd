extends AnimationPlayer

@onready var personaje =  $"../..";

const animaciones_no_prioritarias = ["idle","correr","caminar",""]

func _process(_delta: float) -> void:
	if personaje.en_demo:
		return;
	if esta_ocupado():
		return;
	elif esta_quieto():
		self.play("idle");
	elif personaje.isCorriendo:
		self.play("correr");
	else:
		self.play("caminar");
	pass

func esta_ocupado() -> bool:
	var ocupado = not self.current_animation in animaciones_no_prioritarias;
	return ocupado;

func esta_quieto() -> bool:
	return (personaje.direccion + personaje.auto_movimiento)== Vector2.ZERO || personaje.esperando
