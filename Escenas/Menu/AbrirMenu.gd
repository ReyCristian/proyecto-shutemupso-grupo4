extends Button

@export var menu : VBoxContainer;

func _on_pressed() -> void:
	if menu != null:
		get_parent().hideMenu();
		menu.showMenu();
	pass 
