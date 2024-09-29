extends Node2D

@export var direccion = Vector2.DOWN;

func _ready() -> void:
	$personaje.direccion = direccion;
