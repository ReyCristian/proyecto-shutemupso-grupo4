extends Control

const pre_lvl_1:PackedScene = preload("res://Escenas/nivel_1.tscn");
const pre_lvl_2:PackedScene = preload("res://Escenas/nivel_2.tscn");
const pre_lvl_3:PackedScene = preload("res://Escenas/nivel_3.tscn");

var principal: Node2D;

func _ready() -> void:
	principal = get_tree().current_scene
	randomize()

func _on_lvl_1_pressed() -> void:
	pre_cargar_lvl(pre_lvl_1);
	get_parent().hideMenu()
	principal.ver_pantalla_inicio_nivel()
	pass;


func _on_lvl_2_pressed() -> void:
	pre_cargar_lvl(pre_lvl_2);
	get_parent().hideMenu()
	principal.ver_pantalla_inicio_nivel()
	pass;
	
func _on_lvl_3_pressed() -> void:
	pre_cargar_lvl(pre_lvl_3);
	get_parent().hideMenu()
	principal.ver_pantalla_inicio_nivel()
	pass # Replace with function body.


func pre_cargar_lvl(pre_lvl: PackedScene):
	if principal.lvl_actual != null:
		alerta_cargar_lvl(pre_lvl);
	else:
		cargar_lvl(pre_lvl);
	pass;

func alerta_cargar_lvl(pre_lvl: PackedScene):
	if principal.lvl_actual != null:
		principal.remove_child(principal.lvl_actual)
		principal.lvl_actual.queue_free()
		cargar_lvl(pre_lvl)
	pass
	

func cargar_lvl(pre_lvl: PackedScene):
	principal.lvl_actual = pre_lvl.instantiate();
	principal.lvl_actual.set("archivo_escena",pre_lvl);
	principal.add_child(principal.lvl_actual);
	pass
