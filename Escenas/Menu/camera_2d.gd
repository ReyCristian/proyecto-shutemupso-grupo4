extends Camera2D

# Límites de la cámara
var limite_superior = 130
var limite_derecha = 570
var limite_inferior = 500
var limite_izquierda = 0

# Velocidad de la cámara
var velocidad = 20

# Estado actual del movimiento
enum EstadoMovimiento { ARRIBA, DERECHA, ABAJO, IZQUIERDA }
var estado_actual = EstadoMovimiento.ARRIBA

func _process(delta):
	match estado_actual:
		EstadoMovimiento.ARRIBA:
			position.y -= velocidad * delta
			if position.y <= limite_superior:
				position.y = limite_superior
				estado_actual = EstadoMovimiento.DERECHA
		EstadoMovimiento.DERECHA:
			position.x += velocidad * delta
			if position.x >= limite_derecha:
				position.x = limite_derecha
				estado_actual = EstadoMovimiento.ABAJO
		EstadoMovimiento.ABAJO:
			position.y += velocidad * delta
			if position.y >= limite_inferior:
				position.y = limite_inferior
				estado_actual = EstadoMovimiento.IZQUIERDA
		EstadoMovimiento.IZQUIERDA:
			position.x -= velocidad * delta
			if position.x <= limite_izquierda:
				position.x = limite_izquierda
				estado_actual = EstadoMovimiento.ARRIBA
