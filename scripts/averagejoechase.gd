extends Node
@onready var idle: Node = $"../idle"
@onready var statecontroller: Node = $".."
@onready var chase: Node = $"../chase"
@onready var drawcircle: Node2D = $"../../drawcircle"

@onready var averagecircle: CharacterBody2D = $"../.."
var forgettimer = randf_range(2,5)
var startpos: Vector2
var movespeed = randi_range(300,500)
var direction
func ENTER():
	averagecircle.add_to_group("enemy")
	drawcircle.color = "RED"
func UPDATE(delta):
	direction = (Globalplayerstate.playerposition - averagecircle.global_position).normalized()
	averagecircle.velocity = direction*movespeed
	if Globalplayerstate.shapeshifting:
		if forgettimer > 0:
			forgettimer -= delta
		else:
			statecontroller.changestateto(idle)
func EXIT():
	pass
