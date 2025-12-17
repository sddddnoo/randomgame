extends Node
@onready var drawcircle: Node2D = $"../../drawcircle"
var transition_timer: float
@onready var chase: Node = $"../chase"

func ENTER():
	transition_timer = 1 # 1 sec timer where it signals that its going to transition to evillll
func UPDATE(delta):
	if transition_timer > 0:
		transition_timer -= delta
		if drawcircle.color == Color.RED:
			drawcircle.color = "GREEN"
		elif drawcircle.color == Color.GREEN:
			drawcircle.color = "RED"
	else:
		get_parent().changestateto(chase)
func EXIT():
	pass
