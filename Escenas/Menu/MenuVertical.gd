extends VBoxContainer

@export var esta_abierto: bool = false;

const pos_visible = 55;
const pos_oculto = -385;

func _ready() -> void:
	if esta_abierto:
		position.x = pos_visible;
	else:
		position.x = pos_oculto; 
	pass 


func _process(delta: float) -> void:
	if esta_abierto:
		desplegar(delta);
	else:
		replegar(delta);
	pass

func mostrarMenu() -> void:
	esta_abierto = true;
	
func ocultarMenu() -> void:
	esta_abierto = false;
	
func desplegar(delta):
	visible = true;
	if position.x < pos_visible:
		position.x += 1000*delta;
	else:
		position.x = pos_visible;

func replegar(delta):
	if position.x > pos_oculto:
		position.x -= 1500*delta; 
	elif visible:
		visible = false;
		get_parent().pause_off();
