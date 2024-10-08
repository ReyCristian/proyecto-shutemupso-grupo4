extends Node2D

func _ready() -> void:
	if has_node("VisibleOnScreenEnabler2D"):
		$VisibleOnScreenEnabler2D.connect("screen_exited",Callable(self,"_cuando_patrulla_sale_pantalla"))

func _cuando_patrulla_sale_pantalla() -> void:
	print("adios")
	queue_free()
	pass 
