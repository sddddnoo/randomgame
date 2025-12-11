extends Node2D
var color: Color
func _draw() -> void:
	draw_circle(Vector2.ZERO,50,color,true,0,true) # draw teh circle
	
func _process(delta: float) -> void:
	queue_redraw()
