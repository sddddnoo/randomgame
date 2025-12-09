extends Node
@onready var idle: Node = $"../idle"
@onready var statecontroller: Node = $".."
@onready var chase: Node = $"../chase"
@onready var averagecircle: CharacterBody2D = $"../.."
var movespeed = randi_range(800,1000)
var direction: Vector2
func ENTER():
	Globalplayerstate.averagejoeishostile = true # globally now i know when the average joe hates the player for beinga  square
	print("state changed to chase satate")
func UPDATE(delta):
	if !Globalplayerstate.shapeshifting:
		direction = (Globalplayerstate.playerposition - averagecircle.global_position).normalized()
		averagecircle.velocity = direction*movespeed
	else:
		Globalplayerstate.averagejoeishostile = false
		statecontroller.changestateto(idle)
func EXIT():
	pass
