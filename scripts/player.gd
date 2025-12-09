extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var SPEED: int # horizontal movement speed
var JUMP_VELOCITY: int # jump speed
var varjump: bool
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("changeshape"): #if player wants to be circle
		Globalplayerstate.shapeshifting = true # globally means that player is now a circle
		animated_sprite_2d.play("SWITCH")
	elif Input.is_action_just_released("changeshape"):
		Globalplayerstate.shapeshifting = false # it switches back so now player isnt circle
		animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:
	if Globalplayerstate.shapeshifting:
		JUMP_VELOCITY = -300
		SPEED = 100
	else:
		SPEED = 300.0
		JUMP_VELOCITY = -800.0
	move_and_slide()
	jump()
	basicmove()
	gravity(delta)
	updatepos()

func gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta # applies gravity

func jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		varjump = true
	elif Input.is_action_just_released("ui_accept") and (velocity.y < 0) and varjump: # if jump button is released and player is still going up and varjump is true (varjump is a bool flag so that i cant keep on pressing space to delay me falling down)
		varjump = false
		var varjumpforce = (abs(velocity.y)+100) #abs means no matter if velocity is positive or negative itll change it to positive so when i release the buttton it will make me fall down at the same speed i was jumping at, at the start the jump speed is the same as jumovelocity so if i immediately release itll send me down fast 
		velocity.y += varjumpforce
		
func basicmove():

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
func updatepos():
	Globalplayerstate.playerposition = global_position
	
