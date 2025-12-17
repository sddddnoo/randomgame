extends Node2D
var loadenemy := preload("res://scenees/averagejoe.tscn")
var randleft = randi_range(-1800,-100)
var randright = randi_range(100,1800)
var randcoord : Vector2
var farfromplayer = Globalplayerstate.playerposition - randcoord
var playing: bool = false
var numkills: int # number of kills
func _ready() -> void:
	if randf() > 0.5:  # either its gonna spawn right or left from the player
		randcoord = Vector2(randleft,-100) # idk any better way to do it
	else:
		randcoord = Vector2(randright,-100)
	addenemy(randcoord)
	Bgmusic.play()
	Globalplayerstate.wavestage = 1
func _process(delta: float) -> void:
	if !get_tree().get_first_node_in_group("averagejoe"):
		set_pitch(1)
		$vicotry.play()
		Globalplayerstate.wavestage += 1
		for i in range(Globalplayerstate.wavestage): 
			playing = false
			randcoord = Vector2(randi_range(-1800,1800),randi_range(-1200,1200)) # y- axis: -10000 or 10000 random num and -800 on x axis
			farfromplayer = Globalplayerstate.playerposition - randcoord
			addenemy(randcoord)
	if Bgmusic.get_child(0).is_playing() and !playing: # if the kill sound is playing and !playing is the bool flag so that its only triggered once
		numkills += 1
		const SEMITONE := pow(2.0, 1.0 / 12.0) # mathematical value for 1 semitone
		set_pitch(SEMITONE**numkills)
func addenemy(pos):
		var sprite = loadenemy.instantiate()
		sprite.position = pos
		add_child(sprite)

func set_pitch(x):
	playing = true
	var bus := AudioServer.get_bus_index("pitch")
	var effect := AudioServer.get_bus_effect(bus, 0)
	effect.pitch_scale = x
