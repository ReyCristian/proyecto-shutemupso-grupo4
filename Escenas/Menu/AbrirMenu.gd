extends Button

@export var menu : VBoxContainer;

func _on_pressed() -> void:
	if menu != null:
		get_parent().ocultarMenu();
		menu.mostrarMenu();
	pass 
