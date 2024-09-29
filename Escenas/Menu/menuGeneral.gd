extends Control

var principal: Node2D;
	
func _ready() -> void:
	principal = get_tree().current_scene;

@onready var menus = [$Principal,$Niveles,$Opciones,$OpcionesSonido]

func hideMenu() -> void:
	for menu in menus:
		menu.hideMenu();
	pass

func pause_off() -> bool:
	for menu in menus:
		if menu.visible:
			return false;
	get_tree().paused = false;
	$EnchantedFestival.stream_paused = true;
	return true;
