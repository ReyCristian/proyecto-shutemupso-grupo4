extends Path2D

func marcar_camino(objetivo:Vector2):
	self.curve = self.curve.duplicate()
	self.curve.set_point_position(2,self.to_local(objetivo))
	if self.to_local(objetivo).x > 0:
		self.curve.set_point_position(1,Vector2(50,50))
		self.curve.set_point_in(1,Vector2(-30,0))
		self.curve.set_point_out(1,Vector2(30,0))
	$marcador_a_seguir.progress_ratio = 1
	pass
	
func seleccionar_laser(color:int):
	$PathFollow2D/Laser.seleccionar_laser(color)
