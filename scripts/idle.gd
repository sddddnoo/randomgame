extends Node
@onready var statecontroller: Node = $".."
@onready var chase: Node = $"../chase"
@onready var averagecircle: CharacterBody2D = $"../.."
@onready var rightrc: RayCast2D = $"../../rightrc"
@onready var leftrc: RayCast2D = $"../../leftrc"
@onready var bottomright: RayCast2D = $"../../bottomright"
@onready var bottomleft: RayCast2D = $"../../bottomleft"

var direction: int
var movespeed = 400
func ENTER():
	if averagecircle.is_in_group("enemy"):
		averagecircle.remove_from_group("enemy")
	if randf() > 0.5:
		direction = 1
	else:
		direction = -1
func UPDATE(delta):
	if rightrc.is_colliding() or !bottomright.is_colliding():
		direction = -1
		movespeed = randi_range(300,500)
	elif leftrc.is_colliding() or !bottomleft.is_colliding():
		direction = 1
		movespeed = randi_range(300,500)
	averagecircle.velocity.x = direction*movespeed
	var updatedist = (averagecircle.global_position - Globalplayerstate.playerposition)
	if updatedist.length() < 1000 and !Globalplayerstate.shapeshifting:
		statecontroller.changestateto(chase)
func EXIT():
	pass
