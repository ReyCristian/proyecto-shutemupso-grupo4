extends Area2D


func _on_body_exited(body: Node2D) -> void:
	
	if body.is_in_group("patrullero"):
		body.direccion = -body.direccion;
	pass # Replace with function body.
