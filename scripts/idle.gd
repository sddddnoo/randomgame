extends Node
@onready var statecontroller: Node = $".."
@onready var chase: Node = $"../chase"
@onready var averagecircle: CharacterBody2D = $"../.."
@onready var rightrc: RayCast2D = $"../../rightrc"
@onready var leftrc: RayCast2D = $"../../leftrc"
@onready var downrc: RayCast2D = $"../../downrc"
@onready var uprc: RayCast2D = $"../../uprc"

@onready var drawcircle: Node2D = $"../../drawcircle"

var direction: Vector2 
var movespeed = 400
func ENTER():
	drawcircle.color = "GREEN"
	if averagecircle.is_in_group("enemy"):
		averagecircle.remove_from_group("enemy")
func UPDATE(delta):
	direction += Vector2(randf_range(-1,1),randf_range(-1,1))
	averagecircle.velocity = direction.normalized()*movespeed
	var updatedist = (averagecircle.global_position - Globalplayerstate.playerposition)
	if updatedist.length() < 800 and !Globalplayerstate.shapeshifting:
		statecontroller.changestateto(chase)
func EXIT():
	pass
