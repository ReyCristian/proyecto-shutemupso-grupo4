extends Control


func _ready() -> void:
	pass 
	
func cambiar_volumen(valor:int,nombre_bus:String = "Master"):
	var db_valor = lerp(-80, 0, valor)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(nombre_bus), db_valor)


func _on_check_button_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"),toggled_on)
	pass # Replace with function body.
