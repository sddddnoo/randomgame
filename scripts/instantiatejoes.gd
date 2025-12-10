extends Node2D
var loadenemy := preload("res://scenees/averagejoe.tscn")
var spawn_timer = 1
var numtime: float = 0
func _ready() -> void:
		var sprite = loadenemy.instantiate()
		addenemy(Vector2.ZERO)
	
func _process(delta: float) -> void:
	if spawn_timer > 0:
		spawn_timer -= delta
	else:
		spawn_timer = 1
		numtime += 0.25
		for i in range(1): # was supposed to be int(numtime) but made it 1 cuz it gets too crowded and hard to move
			var randcoord = Vector2(randi_range(-4000,4000),-800) # y- axis: -10000 or 10000 random num and -800 on x axis
			addenemy(randcoord)

func addenemy(pos):
		var sprite = loadenemy.instantiate()
		sprite.position = pos
		add_child(sprite)
