extends AnimationPlayer

@onready var personaje =  $"../..";

func _process(_delta: float) -> void:
	if personaje.en_demo:
		return;
		
	if not self.current_animation in ["idle","correr","caminar","","RESET"]:
		return;
	elif (personaje.direccion + personaje.auto_movimiento)== Vector2.ZERO || personaje.esperando:
		self.play("idle");
	elif personaje.isCorriendo:
		self.play("correr");
	else:
		self.play("caminar");
		
	pass
