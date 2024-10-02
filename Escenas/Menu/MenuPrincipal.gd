extends Control

var menu_principal
var principal: Node2D;
	
func _ready() -> void:
	menu_principal = ParentFinder.find(self,"Menu");
	principal = get_tree().current_scene;
	
func _process(_delta: float) -> void:
	$"../Continuar".visible = $"../../Niveles/Control".nivel_actual_indice > 0 
	var isMenuOpened = get_parent().isShowed
	if es_menu_principal() and isMenuOpened:
		return; #El menu principal esta abierto
	if Input.is_action_just_released("ui_cancel"):
		menu_principal.hideMenu();
		if not isMenuOpened:
			get_parent().showMenu();
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
	menu_principal.hideMenu();
