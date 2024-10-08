extends Area2D

@onready var personaje = $"..";
@onready var sprite = $"../Sprite2D"

signal muerte;

func _ready() -> void:
	deshabilitar_colisiones_enemigo();
	conectar_puntaje_enemigos();

func tomar_daño():
	if personaje.muerto or recibio_daño():
		return;
	personaje.magia.magia_lista = false
	personaje.vida -=1;
	if personaje.vida <=0:
		morir()
	else:
		sprite.tomar_daño()

func morir():
	if personaje.muerto:
		return;
	sprite.morir();
	if personaje.is_in_group("enemigo"):
		emit_signal("muerte",personaje.skin)
	if not personaje.en_demo and not personaje.is_in_group("demo"):
		personaje.muerto = true;
		self.get_node("CollisionShape2D2").queue_free();
		$"../espada".queue_free();
		$"../CollisionShape2D".queue_free();
	
func recibio_daño() -> bool:
	return sprite.recibio_daño()
func _cuando_area_entra_hitbox(area: Area2D) -> void:
	if area.is_in_group("laser") and not (area.get_parent().is_in_group("laser_p") and personaje.is_in_group("heroe")):
		tomar_daño();
		area.get_parent().queue_free();

func _cuando_cuerpo_entra_en_hitbox(body: Node2D) -> void:
	if personaje.is_in_group("enemigo") and body.is_in_group("heroe") and sprite.golpe_preparado() and not personaje.tiene_espada:
		$"../espada".hacer_daño();
		

func conectar_puntaje_enemigos():
	if get_tree().get_nodes_in_group("principal").size() > 0:
		var principal = get_tree().get_nodes_in_group("principal")[0]
		if principal != null: 
			connect("muerte",Callable(principal,"_on_enemigo_muere"))


func liberar_padre():
	var parent = personaje.get_parent()
	while parent != null:
		if parent.is_in_group("liberar_al_morir"):
			parent.queue_free()
			break
		parent = parent.get_parent()
		
func deshabilitar_colisiones_enemigo():
	if personaje.is_in_group("enemigo"):
		personaje.set_collision_layer(1);
		personaje.set_collision_mask(0);

func _cuando_salga_de_la_pantalla() -> void:
	if personaje.is_in_group("demo") or personaje.en_demo:
		return
	if personaje.caminar.esta_en_camino_fijo():
		return
	if personaje.is_in_group("heroe"):
		personaje.hitbox.morir();
		return
	personaje.queue_free();
	liberar_padre();

func _cuando_completa_animacion_muerte():
	if personaje.is_in_group("demo"):
		return;
	if personaje.muerto and personaje.limpiar_cadaver:
		queue_free()
		personaje.queue_free()
		liberar_padre()
		if personaje.is_in_group("heroe"):
			get_tree().get_first_node_in_group("principal").derrota();
	
