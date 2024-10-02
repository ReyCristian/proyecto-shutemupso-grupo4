extends Node2D

func is_lleno():
	return $"Corazon lleno".visible
func daño():
	$AnimationPlayer.play("Recibir daño 1")

func _ready() -> void:
	$AnimationPlayer.play("Idle")
