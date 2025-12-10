extends Node
@onready var idle: Node = $"../idle"
@onready var statecontroller: Node = $".."
@onready var chase: Node = $"../chase"
@onready var averagecircle: CharacterBody2D = $"../.."
var forgettimer = randf_range(2,5)
var startpos: Vector2
var movespeed = randi_range(500,900)
var direction
func ENTER():
	averagecircle.add_to_group("enemy")
func UPDATE(delta):
	direction = sign(Globalplayerstate.playerposition.x - averagecircle.global_position.x)
	averagecircle.velocity.x = direction*movespeed
	if Globalplayerstate.shapeshifting:
		if forgettimer > 0:
			forgettimer -= delta
		else:
			statecontroller.changestateto(idle)
func EXIT():
	pass
