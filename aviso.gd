extends Sprite2D

func liberar_padre():
	var parent = get_parent()
	while parent != null:
		if parent.is_in_group("liberar_al_morir"):
			parent.queue_free()
			break
		parent = parent.get_parent()
