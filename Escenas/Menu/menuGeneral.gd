extends Control

var principal: Node2D;
	
func _ready() -> void:
	principal = get_tree().current_scene;

func hideMenu() -> void:
	$Niveles.hideMenu();
	$Principal.hideMenu();
	pass


func pause_off() -> bool:
	if $Niveles.visible or $Principal.visible:
		return false;
	get_tree().paused = false
	return true;
