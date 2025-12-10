extends Area2D
var movespeed = 5000
var direction : float
var timer: float = 1
func _ready() -> void:
	direction = Globalplayerstate.playerdirection
func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
	else:
		queue_free()
	position.x += movespeed*direction*delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()
