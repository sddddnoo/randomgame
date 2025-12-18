extends CharacterBody2D
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2
@onready var camera_2d: Camera2D = $Camera2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var startpos: Vector2
var SPEED: float # horizontal movement speed
var JUMP_VELOCITY: float # jump speed
var varjump: bool
var bulletspawn := preload("res://scenees/bullet.tscn")
var cooldowntimer: float
var timer_reset: bool = false
var direction: float
func _ready() -> void:
	Globalplayerstate.shapeshifting = false
	startpos = global_position
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("changeshape"): #if player wants to be circle
		Globalplayerstate.shapeshifting = true # globally means that player is now a circle
		animated_sprite_2d.play("SWITCH")
	elif Input.is_action_just_released("changeshape"):
		Globalplayerstate.shapeshifting = false # it switches back so now player isnt circle
		animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:
	if Globalplayerstate.shapeshifting:
		JUMP_VELOCITY = -800
		SPEED = 600
	else:
		SPEED = 2000.0
		JUMP_VELOCITY = -1500.0
	move_and_slide()
	#jump()
	basicmove()
	#gravity(delta)
	updatepos()
	collidewithenemy()
	spawnbullet(delta)
	changesizewithbar()
	if timer_reset:
		startbulletcooldown(delta)
func gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta * 2# applies gravity

func jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		varjump = true
	elif Input.is_action_just_released("ui_accept") and (velocity.y < 0) and varjump: # if jump button is released and player is still going up and varjump is true (varjump is a bool flag so that i cant keep on pressing space to delay me falling down)
		varjump = false
		var varjumpforce = (abs(velocity.y)+100) #abs means no matter if velocity is positive or negative itll change it to positive so when i release the buttton it will make me fall down at the same speed i was jumping at, at the start the jump speed is the same as jumovelocity so if i immediately release itll send me down fast 
		velocity.y += varjumpforce
		
func basicmove():
	var normaldirection = Vector2.ZERO
	normaldirection.x = Input.get_axis("ui_left", "ui_right")
	normaldirection.y = Input.get_axis("ui_up","ui_down")
	velocity = normaldirection.normalized()*SPEED
	
		
	if direction != 0:
		Globalplayerstate.lastdirection = direction
func updatepos():
	Globalplayerstate.playerposition = global_position
	
func spawnbullet(delta):
	if Input.is_action_just_pressed("attack") and !timer_reset:
		var bullet = bulletspawn.instantiate()
		timer_reset = true
		cooldowntimer = 0.3
		bullet.global_position = global_position
		get_tree().current_scene.add_child(bullet)
		
func startbulletcooldown(delta):
	if cooldowntimer > 0:
		cooldowntimer -= delta
	else:
		timer_reset = false
	
func collidewithenemy():
	var count_col = get_slide_collision_count()
	for i in range(count_col):
		var collider := get_slide_collision(i)
		var oncecollide = false
		var collision = collider.get_collider()
		if collision.is_in_group("enemy") and collision:
			if get_tree() and !oncecollide:
				Globalplayerstate.abilitybar -= 30 # decreases the bar by 30
				oncecollide = true
		else:
			oncecollide = false
func changesizewithbar():
	var changesize: Vector2
	var scale: float = (Globalplayerstate.abilitybar)/30
	var camerascale: Vector2 = Vector2(0.1/scale,0.1/scale)
	changesize.x = scale
	changesize.y = changesize.x
	self.scale = changesize
	collision_shape_2d_2.scale = changesize
	camera_2d.zoom = camerascale
