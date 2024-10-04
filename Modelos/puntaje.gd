extends Node2D

const puntaje = {
	slime = 100,
	peon = 50,
	mago = 200,
	patrulla = 100,
	arbusto = 10,
	cofre = 1000
}

var contador = {
	slime = 0,
	peon = 0,
	mago = 0,
	patrulla = 0,
	arbusto = 0,
	cofre = 0
}
const asociacion_puntajes = {
		ListasTexturas.texturas_personaje.ORC_PEON_RED:"peon",
		ListasTexturas.texturas_personaje.ORC_GRUNT:"patrulla",
		ListasTexturas.texturas_personaje.ORC_SOLDIER_RED:"mago",
		ListasTexturas.texturas_personaje.SLIME:"slime"
	}

func _on_enemigo_muere(skin: ListasTexturas.texturas_personaje) -> void:
	if asociacion_puntajes.has(skin):
		contador[asociacion_puntajes[skin]]+=1;

func _on_obstaculo_roto(id:String) -> void:
		contador[id]+=1;
