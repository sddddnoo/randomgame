extends Area2D
var movespeed = 5000
var timer: float = 1
var direction: Vector2
func _ready() -> void:
	print("bullet spawned")
	direction = get_local_mouse_position().normalized()
	rotate(direction.angle())
func _process(delta: float) -> void:
	if timer > 0:
		timer -= delta
	else:
		queue_free()
	position += movespeed*direction*delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()
