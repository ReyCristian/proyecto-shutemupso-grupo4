extends Control

var menu_principal
var principal: Node2D;
	
func _ready() -> void:
	menu_principal = ParentFinder.find(self,"Menu");
	principal = get_tree().current_scene;
	
func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		var isMenuOpened = get_parent().isShowed
		menu_principal.hideMenu();
		if not isMenuOpened:
			get_parent().showMenu();
			#get_tree().paused = true
	pass

func _on_salir_pressed() -> void:
	get_tree().quit()
	pass
