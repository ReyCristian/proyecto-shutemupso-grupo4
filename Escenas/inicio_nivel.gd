extends CanvasLayer

var reiniciar:bool = false;
var nivel=0;

func _physics_process(_delta: float) -> void:
	if $VisibleOnScreenEnabler2D.is_on_screen():
		$ColorRect/Tutorial_controles/personaje4.magia.shot()
		$ColorRect/Tutorial_controles/personaje5.magia.shot(2)

func _on_timer_timeout() -> void:
	if $ColorRect/Tutorial_controles/personaje3/Sprite2D.golpe_preparado():
		$ColorRect/Tutorial_controles/personaje3/Sprite2D.dar_golpe_espada();
		$ColorRect/Tutorial_controles/personaje4.magia.detener_shot()
		$ColorRect/Tutorial_controles/personaje5.magia.detener_shot()
	else:
		$ColorRect/Tutorial_controles/personaje3/Sprite2D.preparar_golpe_espada();
		$ColorRect/Tutorial_controles/personaje4.magia.preparar_shot()
		$ColorRect/Tutorial_controles/personaje5.magia.preparar_shot()

func ver_pantalla_inicio_nivel(_nivel:int):
	get_tree().paused = true;
	$ColorRect/Tutorial_controles/suelo_para_disparos.add_to_group("nivel")
	visible = true;
	$Intense.stream_paused = false;
	mostrar_boton_listo()
	mostrar_tutorial_controles()
	$ColorRect/personaje.get_node("Sprite2D").demo_mode.timer.paused = false;
	reiniciar = false;
	nivel = _nivel;
	
func mostrar_boton_listo():
	$ColorRect/listo.visible = true;
	$ColorRect/listo.text = "LISTO";
	$ColorRect/listo.pivot_offset.x = 27
	
func mostrar_tutorial_controles():
	$ColorRect/Tutorial_controles.visible = true;
	$ColorRect/puntajes.visible = false;
	

func _on_listo_pressed() -> void:
	print(nivel)
	if reiniciar:
		get_tree().get_nodes_in_group("principal")[0].reiniciar_nivel()
	if nivel == 0:
		get_tree().get_nodes_in_group("principal")[0].final_del_juego()
	$ColorRect/Tutorial_controles/suelo_para_disparos.remove_from_group("nivel")
	visible = false;
	get_tree().paused = false;
	
func detener():
	$Intense.stream_paused = true;
	#$ColorRect/listo.visible = false;
	
func ver_pantalla_derrota(puntaje,referencia):
	mostrar_boton_reiniciar()
	$ColorRect/personaje.hitbox.morir();
	$ColorRect/personaje.sprite.demo_mode.timer.paused = true;
	ver_pantalla_puntaje(puntaje,referencia,nivel);
	
func mostrar_boton_reiniciar():
	reiniciar = true;
	$ColorRect/listo.visible = true;
	$ColorRect/listo.text = "Reiniciar";
	$ColorRect/listo.pivot_offset.x = 61;

func ver_pantalla_puntaje(puntaje,referencia,_nivel):
	nivel = _nivel;
	get_tree().paused = true;
	$ColorRect/Tutorial_controles/suelo_para_disparos.add_to_group("nivel")
	visible = true;
	$Intense.stream_paused = false;	
	reset_puntajes()
	$ColorRect/Tutorial_controles.visible = false;
	$ColorRect/puntajes.visible = true;
	var total=0
	for enemigo in $ColorRect/puntajes/enemigos.get_children():
		for contador in range(0,puntaje[enemigo.name]*20+1,puntaje[enemigo.name] if puntaje[enemigo.name]>0 else 1):
			await get_tree().create_timer(0.1).timeout
			enemigo.get_node("HBoxContainer").get_node("contador").text = "x" + str(contador/20)
		await get_tree().create_timer(0.5).timeout
		enemigo.get_node("HBoxContainer").get_node("puntaje").text = "x" + str(referencia[enemigo.name])
		var subtotal = puntaje[enemigo.name] * referencia[enemigo.name]
		for _subtotal in range(0,subtotal*20+1,subtotal if puntaje[enemigo.name]>0 else 1):
			await get_tree().create_timer(0.1).timeout
			enemigo.get_node("HBoxContainer").get_node("subtotal").text = "= " + str(_subtotal/20)
		total += puntaje[enemigo.name] * referencia[enemigo.name]
	for destruible in $ColorRect/puntajes/destruibles.get_children():
		for contador in range(0,puntaje[destruible.name]*20+1,puntaje[destruible.name] if puntaje[destruible.name]>0 else 1):
			await get_tree().create_timer(0.1).timeout
			destruible.get_node("contador").text = "x" + str(contador/20)
		await get_tree().create_timer(0.5).timeout
		destruible.get_node("puntaje").text = "x" + str(referencia[destruible.name])
		var subtotal = puntaje[destruible.name] * referencia[destruible.name]
		for _subtotal in range(0,subtotal*20+1,subtotal if puntaje[destruible.name]>0 else 1):
			await get_tree().create_timer(0.1).timeout
			destruible.get_node("subtotal").text = "= " + str(_subtotal/20)
		total += puntaje[destruible.name] * referencia[destruible.name]
	for _total in range(0,total*20+1,total if total>0 else 1):
		await get_tree().create_timer(0.1).timeout
		$ColorRect/puntajes/total.text = str(_total/20)

func reset_puntajes():
	$ColorRect/puntajes/total.text = ""
	for enemigo in $ColorRect/puntajes/enemigos.get_children():
		enemigo.get_node("HBoxContainer").get_node("contador").text = ""
		enemigo.get_node("HBoxContainer").get_node("puntaje").text = ""
		enemigo.get_node("HBoxContainer").get_node("subtotal").text = ""
	for destruible in $ColorRect/puntajes/destruibles.get_children():
		destruible.get_node("contador").text = ""
		destruible.get_node("puntaje").text = ""
		destruible.get_node("subtotal").text = ""
