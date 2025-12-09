extends Node
@onready var statecontroller: Node = $".."
@onready var chase: Node = $"../chase"
@onready var averagecircle: CharacterBody2D = $"../.."
var direction = 1
const movespeed = 200
var randomtimer = randf_range(0,3)
func ENTER():
	print("idle state yeaaaah")
func UPDATE(delta):
	if randomtimer > 0:
		randomtimer -= delta
	else:
		randomtimer = randf_range(0,3)
		print(randomtimer)
		direction = -direction
	averagecircle.velocity.x = direction*movespeed
	var updatedist = (averagecircle.global_position - Globalplayerstate.playerposition)
	if updatedist.length() < 1000 and !Globalplayerstate.shapeshifting:
		statecontroller.changestateto(chase)
func EXIT():
	pass
