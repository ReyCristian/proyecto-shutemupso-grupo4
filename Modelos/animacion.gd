extends AnimationPlayer

@onready var personaje =  $"../..";

func _process(_delta: float) -> void:
	if get_tree().current_scene.name == "personaje":
		return;
	
	if (personaje.direccion + personaje.auto_movimiento)!= Vector2.ZERO && not personaje.esperando:
		if personaje.isCorriendo:
			self.play("correr");
		else:
			self.play("caminar");
	else:
		self.play("idle");
	pass
