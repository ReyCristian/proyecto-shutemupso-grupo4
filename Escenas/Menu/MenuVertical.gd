extends VBoxContainer

@export var isShowed: bool = false;

const showPos = 55;
const hidePos = -385;

func _ready() -> void:
	if isShowed:
		position.x = showPos;
	else:
		position.x = hidePos; 
	pass 


func _process(delta: float) -> void:
	if isShowed:
		visible = true;
		if position.x < showPos:
			position.x += 1000*delta;		
	else:
		if position.x > hidePos:
			position.x -= 1500*delta; 
		elif visible:
			visible = false;
			get_parent().pause_off();
	pass

func showMenu() -> void:
	isShowed = true;
	
func hideMenu() -> void:
	isShowed = false;
