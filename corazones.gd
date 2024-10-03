extends Node2D
var heroe
func _process(_delta: float) -> void:
	var nivel = get_tree().get_first_node_in_group("nivel")
	var Heroes = get_tree().get_nodes_in_group("heroe")
	for _heroe in Heroes:
		if nivel.is_ancestor_of(_heroe):
			heroe = _heroe
	if heroe == null:
		return
	if heroe.vida <3 and $"Corazon 3".is_lleno():
		$"Corazon 3".daño()
		
	if heroe.vida <2 and $"Corazon 2".is_lleno():
		$"Corazon 2".daño()
		
	if heroe.vida <1 and $"Corazon 1".is_lleno():
		$"Corazon 1".daño()
