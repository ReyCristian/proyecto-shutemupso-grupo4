extends Control

var principal

func _ready() -> void:
	principal = ParentFinder.find(self,"Menu");

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_cancel"):
		var isMenuOpened = get_parent().isShowed
		principal.hideMenu();
		if not isMenuOpened:
			get_parent().showMenu();
	pass

func _on_salir_pressed() -> void:
	get_tree().quit()
	pass
