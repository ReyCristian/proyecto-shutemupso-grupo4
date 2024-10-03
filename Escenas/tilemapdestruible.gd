extends TileMapLayer

const list_destruibles = {
	Vector2i(13,8):"arbusto",
	Vector2i(14,8):"arbusto",
	Vector2i(16,1):"cofre"
}

signal destruido;

func _ready() -> void:
	conectar_puntaje_destruibles()

func romper_posicion_global(posicion_global:Vector2):
	var cell_pos = local_to_map(to_local(posicion_global))
	var destruido_id = self.get_cell_atlas_coords(cell_pos)
	erase_cell(cell_pos)
	if list_destruibles.has(destruido_id):
		emit_signal("destruido",list_destruibles[destruido_id])


func conectar_puntaje_destruibles():
	var principal = get_tree().get_nodes_in_group("principal")[0]
	if principal != null: 
		connect("destruido",Callable(principal,"_on_obstaculo_roto"))
