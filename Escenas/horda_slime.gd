extends Area2D

@onready var posicion_inicial;

func _ready():
	posicion_inicial = global_position;
	var animated_sprite = $AnimatedSprite2D
	var collision_shape = $CollisionShape2D.shape as RectangleShape2D
	var sprite_width = 8
	var sprite_height = 4

	var half_sprite_width = sprite_width / 2.0
	var half_sprite_height = sprite_height / 2.0

	var start_x = -collision_shape.extents.x + half_sprite_width + $CollisionShape2D.position.x
	var end_x = collision_shape.extents.x - half_sprite_width + $CollisionShape2D.position.x
	var step_x = sprite_width

	var start_y = -collision_shape.extents.y + half_sprite_height + $CollisionShape2D.position.y
	var end_y = collision_shape.extents.y - half_sprite_height + $CollisionShape2D.position.y
	var step_y = sprite_height

	for x in range(start_x, end_x, step_x):
		for y in range(start_y, end_y, step_y):
			var clone = animated_sprite.duplicate()
			clone.position = Vector2(x+randi()%(sprite_width/2), y+randi()%(sprite_height/2))
			clone.play()
			clone.set_frame_and_progress(randi()%7,0)
			add_child(clone)

func _process(_delta: float) -> void:
	global_position = posicion_inicial;
