extends AnimatedSprite2D




func _process(_delta: float) -> void:
	if randi()%100==0:
		set_frame_and_progress(1,0)
	pass
