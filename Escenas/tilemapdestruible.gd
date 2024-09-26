extends TileMapLayer


func romper_posicion_global(posicion_global:Vector2):
	var cell_pos = local_to_map(to_local(posicion_global))
	erase_cell(cell_pos)
