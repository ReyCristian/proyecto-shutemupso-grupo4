extends Node2D


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	$personaje.visible=true;
	$personaje.process_mode = Node.PROCESS_MODE_INHERIT
	pass # Replace with function body.
