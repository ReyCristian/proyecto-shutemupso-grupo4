extends ProgressBar

@export var jefe: CharacterBody2D

var vida_maxima:int;
var valor = 0;

signal listo

func _ready() -> void:
	seleccionar_jefe(jefe);

func _process(delta: float) -> void:
	if is_instance_valid(jefe):
		valor = float(jefe.vida) / vida_maxima
	else:
		valor = 0;
	if value < valor - 0.1 * delta:
		value += 0.1 * delta;
	elif value > valor + 0.1 * delta:
		value -= 0.1 * delta;
	else:
		emit_signal("listo")
		value = valor;

func seleccionar_jefe(nuevo_jefe):
	vida_maxima = nuevo_jefe.vida;
	jefe = nuevo_jefe;


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	value = 0;
	self.visible = true;
	pass
