extends Label
func _process(delta: float) -> void:
	self.text = "Stage " + str(Globalplayerstate.wavestage)
