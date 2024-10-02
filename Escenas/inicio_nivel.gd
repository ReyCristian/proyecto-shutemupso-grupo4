extends CanvasLayer

var reiniciar:bool = false;

func _physics_process(_delta: float) -> void:
	if $VisibleOnScreenEnabler2D.is_on_screen():
		$ColorRect/Tutorial_controles/personaje4.shot()
		$ColorRect/Tutorial_controles/personaje5.shot(2)

func _on_timer_timeout() -> void:
	if $ColorRect/Tutorial_controles/personaje3/Sprite2D.golpe_preparado():
		$ColorRect/Tutorial_controles/personaje3/Sprite2D.dar_golpe_espada();
		$ColorRect/Tutorial_controles/personaje4.detener_shot()
		$ColorRect/Tutorial_controles/personaje5.detener_shot()
	else:
		$ColorRect/Tutorial_controles/personaje3/Sprite2D.preparar_golpe_espada();
		$ColorRect/Tutorial_controles/personaje4.preparar_shot()
		$ColorRect/Tutorial_controles/personaje5.preparar_shot()

func ver_pantalla_inicio_nivel():
	get_tree().paused = true;
	$ColorRect/Tutorial_controles/suelo_para_disparos.add_to_group("nivel")
	visible = true;
	$Intense.stream_paused = false;
	$ColorRect/listo.visible = true;
	$ColorRect/listo.text = "LISTO";
	$ColorRect/Tutorial_controles.visible = true;
	$ColorRect/personaje.get_node("Sprite2D").demo_mode.timer.paused = false;
	reiniciar = false;
	
func _on_listo_pressed() -> void:
	if reiniciar:
		get_tree().get_nodes_in_group("principal")[0].reiniciar_nivel()
	$ColorRect/Tutorial_controles/suelo_para_disparos.remove_from_group("nivel")
	visible = false;
	get_tree().paused = false;
	
func detener():
	$Intense.stream_paused = true;
	$ColorRect/listo.visible = false;
	
func ver_pantalla_derrota():
	get_tree().paused = true;
	$ColorRect/Tutorial_controles/suelo_para_disparos.add_to_group("nivel")
	visible = true;
	$Intense.stream_paused = false;
	$ColorRect/listo.visible = true;
	$ColorRect/listo.text = "Reiniciar";
	reiniciar = true;
	$ColorRect/Tutorial_controles.visible = false;
	$ColorRect/personaje.morir();
	$ColorRect/personaje.get_node("Sprite2D").demo_mode.timer.paused = true;
