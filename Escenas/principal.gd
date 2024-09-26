extends Node2D

const pre_fondo_menu = preload("res://Escenas/Menu/fondo_menu.tscn");
var lvl_actual: Node2D = null; 

func _ready() -> void:
	$Menu_Hub/Menu/Niveles/Control.cargar_lvl(pre_fondo_menu);
	pass
