extends CharacterBody2D
var despawn_timer = 5
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity += get_gravity() * delta
		if get_slide_collision_count() <= 0:
			if despawn_timer > 0:
				despawn_timer -= delta
			else:
				queue_free()
	move_and_slide()
