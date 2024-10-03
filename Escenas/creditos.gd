extends AnimationPlayer

func _ready() -> void:
	play("animacion creditos")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().queue_free()


func _on_animation_finished(anim_name: StringName) -> void:
	get_parent().queue_free()
