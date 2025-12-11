extends Camera2D
var zomceff = Vector2(0.01,0.01)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("upscroll"):
		zoom += zomceff
	elif Input.is_action_just_pressed("downscroll"):
		zoom -= zomceff
