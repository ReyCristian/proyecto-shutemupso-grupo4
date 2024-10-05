extends Node2D

@onready var personaje = $"..";
@onready var sprite = $"../Sprite2D"

var disparo_habilitado:bool = true;
var magia_lista:bool = false;
var magia_lanzada:bool = false;
var pre_laser:Resource = preload("res://Modelos/laser.tscn");

func _ready() -> void:
	guardar_puntos_disparo();

#Esta funcion se llama desde el controlador del personaje
func preparar_shot(ataque: int = 1):
	if personaje.muerto or personaje.hitbox.recibio_daño():
		return
	auto_apuntar()
	sprite.shot(ataque)

#Esta funcion la llama la animacion cuando esta lista para lanzar poderes
func set_magia_lista():
	magia_lista = true;

func shot(ataque: int = 1):
	if personaje.muerto or personaje.hitbox.recibio_daño():
		return;
	if disparo_habilitado and magia_lista:
		magia_lanzada = false;
		auto_apuntar()
		var laser = pre_laser.instantiate()
		get_tree().get_nodes_in_group("nivel")[0].add_child(laser)
		var origen_disparo = obtener_origen_disparo(sprite.direccion.obtener_angulo())
		seleccionar_tipo_laser(laser);
		laser.global_position = origen_disparo.global_position
		dar_direccion(laser,origen_disparo);
		disparo_habilitado = false
		await get_tree().create_timer(0.0 if ataque==1 else 0.5).timeout
		disparo_habilitado = true
	
func set_magia_lanzada():
	magia_lanzada = true;

func detener_shot():
	if not (personaje.muerto or personaje.hitbox.recibio_daño()):
		sprite.detener_shot();
		magia_lista = false;

var puntos_disparo = {}

func guardar_puntos_disparo():
	for origen_disparo in $puntos_disparo.get_children():
		puntos_disparo[int(round(origen_disparo.rotation_degrees))] = origen_disparo
		
func obtener_origen_disparo(angulo_deg: int) -> Node2D:
	return puntos_disparo[angulo_deg];

func obtener_punto_disparo_cercano(angulo_deg: int) -> Node2D:
	var punto_disparo_cercano = $"puntos_disparo/Punto 1"
	var diferencia_minima = 25
	for angulo in puntos_disparo.keys():
		var diferencia = abs(angulo - angulo_deg)
		if diferencia < diferencia_minima:
			diferencia_minima = diferencia
			punto_disparo_cercano = puntos_disparo[angulo]
	return punto_disparo_cercano
	
func auto_apuntar():
	if personaje.auto_apuntado != 360:
		sprite.direccion.auto_apuntar(personaje.auto_apuntado)
	pass

func dar_direccion(laser,origen_disparo):
	if personaje.auto_apuntado == 360:
		laser.rotation = origen_disparo.rotation 
	else:
		laser.rotation = deg_to_rad(personaje.auto_apuntado);

func seleccionar_tipo_laser(laser):
	if personaje.is_in_group("heroe"):
		laser.add_to_group("laser_p")
	else:
		laser.seleccionar_laser(2);
