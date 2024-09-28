extends AnimationPlayer

@onready var personaje =  $"../..";

const animaciones_no_prioritarias = ["idle","correr","caminar","","RESET"]

func _process(_delta: float) -> void:
	if personaje.en_demo:
		return;
	if esta_ocupado():
		return;
	elif (personaje.direccion + personaje.auto_movimiento)== Vector2.ZERO || personaje.esperando:
		self.play("idle");
	elif personaje.isCorriendo:
		self.play("correr");
	else:
		self.play("caminar");
		
	pass

func esta_ocupado() -> bool:
	return not self.current_animation in animaciones_no_prioritarias;
