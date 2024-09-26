extends Node

class_name ParentFinder

static func find_principal(start_node: Node) -> Node2D:
	return find(start_node, "Principal");

static func find(start_node: Node,nombre: String) -> Node2D:
	var principal: Node
	var current_node = start_node
	while current_node != null:
		if current_node is Node and current_node.name == nombre:
			principal = current_node
			break
		current_node = current_node.get_parent()
	return principal;
