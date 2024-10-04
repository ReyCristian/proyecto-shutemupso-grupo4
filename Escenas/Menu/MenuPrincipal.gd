extends Control

var menu_principal
var principal: Node2D;
	
func _ready() -> void:
	menu_principal = ParentFinder.find(self,"Menu");
	principal = get_tree().current_scene;
	
func _process(_delta: float) -> void:
	$"../Continuar".visible = $"../../Niveles/Control".nivel_actual_indice > 0 
	var esta_menu_abierto = get_parent().esta_abierto
	if es_menu_principal() and esta_menu_abierto:
		return; #El menu principal esta abierto
	if Input.is_action_just_released("ui_cancel"):
		menu_principal.ocultarMenu();
		if not esta_menu_abierto:
			get_parent().mostrarMenu();
			$"../../EnchantedFestival".stream_paused = false;
			principal.detener_pantalla_inicio_nivel()
			if not es_menu_principal():
				get_tree().paused = true
	pass

func _on_salir_pressed() -> void:
	get_tree().quit()
	pass

func es_menu_principal() ->bool :
	return principal.lvl_actual.name == "Fondo_menu"

func _on_continuar_pressed() -> void:
	menu_principal.ocultarMenu();


func _on_creditos_pressed() -> void:
	var creditos = preload("res://Escenas/creditos 1.tscn").instantiate();
	get_tree().current_scene.add_child(creditos);
