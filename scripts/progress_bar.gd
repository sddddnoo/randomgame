extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globalplayerstate.abilitybar = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = Globalplayerstate.abilitybar
	if value <= 0:
		get_tree().reload_current_scene()
