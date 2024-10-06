extends Node2D

@onready var personaje = $"..";
@onready var sprite = $"../Sprite2D"

func dar_golpe(body: Node2D = null) -> void:
	if personaje.muerto or personaje.hitbox.recibio_daño():
		return;
	if personaje.is_in_group("demo"):
		$sonido_espada.stream_paused = true
	if body!=null:
		sprite.direccion.poner_direccion(body.global_position - global_position)
	if personaje.tiene_espada:
		sprite.preparar_golpe_espada();
	else:
		sprite.dar_golpe();

func dar_golpe_espada():
	sprite.dar_golpe_espada();

func hacer_daño():
	var golpeados = obtener_cuerpos_en_rango();
	for golpeado in golpeados:
		if golpeado.is_in_group("vivo") and golpeado != personaje:
			golpeado.hitbox.tomar_daño()
		if golpeado.is_in_group("TileMapDestruible"):
			personaje.romper_objeto_de_mapa(golpeado);

func obtener_cuerpos_en_rango(): 
	if personaje.tiene_espada:
		return $area_espada.get_overlapping_bodies()
	else:
		return $"../hitbox".get_overlapping_bodies()


func _cuando_cuerpo_entra_zona_hostilidad(body: Node2D) -> void:
	if personaje.is_in_group("enemigo") and body.is_in_group("heroe"):
		dar_golpe(body);

func _cuando_cuerpo_entra_area_espada_o_sale_area_hostilidad(body: Node2D) -> void:
	if personaje.is_in_group("enemigo") and body.is_in_group("heroe") and sprite.golpe_preparado() and personaje.tiene_espada:
		dar_golpe_espada();
