extends HSlider

enum bus_list {
	MASTER,
	MUSICA,
	EFECTOS
}

@export var bus:bus_list;

const bus_name = {
	bus_list.MASTER: "Master",
	bus_list.MUSICA: "Musica",
	bus_list.EFECTOS: "Efectos"
}

func _ready() -> void:
	cambiar_volumen(int(value),bus_name[bus])


func _on_value_changed(valor: int) -> void:
	cambiar_volumen(valor,bus_name[bus])

func cambiar_volumen(valor:int,nombre_bus:String = "Master"):
	var valor_adaptado = 0.0001*pow(valor,2)
	var db_valor = linear_to_db(valor_adaptado)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(nombre_bus), db_valor)
