extends ParallaxBackground
@export var velocidad = 25;


func _physics_process(delta: float) -> void:
	scroll_offset.y += velocidad * delta;
	
