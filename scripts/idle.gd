extends Node
@onready var chase: Node = $"../chase"
@onready var averagecircle: CharacterBody2D = $"../.."
@onready var transition: Node = $"../transition"
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
	if updatedist.length() < 2000 and !Globalplayerstate.shapeshifting: # if enemy is close to player
		get_parent().changestateto(transition) # blinks red and green to signal transition to player
func EXIT():
	pass
