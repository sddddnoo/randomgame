extends Node2D
var loadenemy := preload("res://scenees/averagejoe.tscn")
var randleft = randi_range(-4000,-1000)
var randright = randi_range(1000,4000)
var randcoord : Vector2
var farfromplayer = Globalplayerstate.playerposition - randcoord
var increasewave: float = 3
func _ready() -> void:
	if randf() > 0.5:
		randcoord = Vector2(randleft,-100)
	else:
		randcoord = Vector2(randright,-100)
	addenemy(randcoord)
	Bgmusic.play()
func _process(delta: float) -> void:
	if get_tree().get_first_node_in_group("averagejoe"):
		$vicotry.play()
		Globalplayerstate.wavestage += 1
		for i in range(int(increasewave)): 
			increasewave += 0.25
			randcoord = Vector2(randi_range(-4000,4000),randi_range(-2000,2000)) # y- axis: -10000 or 10000 random num and -800 on x axis
			farfromplayer = Globalplayerstate.playerposition - randcoord
			if farfromplayer.length() > 500:
				addenemy(randcoord)

func addenemy(pos):
		var sprite = loadenemy.instantiate()
		sprite.position = pos
		add_child(sprite)
