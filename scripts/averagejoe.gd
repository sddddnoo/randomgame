extends CharacterBody2D
var despawn_timer = 5

func _process(delta: float) -> void:
	move_and_slide()
