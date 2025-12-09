extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -800.0
var shapeshift: bool = false
var varjump: bool
var grav = 1000
func _process(delta: float) -> void:
	if Input.is_action_pressed("changeshape") and !shapeshift:
		animated_sprite_2d.play("SWITCH")
		shapeshift = true
	elif Input.is_action_just_released("changeshape"):
		shapeshift = false
		animated_sprite_2d.play("default")

func _physics_process(delta: float) -> void:

	if !shapeshift:
		jump()
		basicmove()
	else:
		velocity.x *= 0
		if velocity.y < 0:
			velocity.y *= 0.3
	move_and_slide()
	gravity(delta)

func gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

func jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		varjump = true
	elif Input.is_action_just_released("ui_accept") and (velocity.y < 0) and varjump:
		varjump = false
		var varjumpforce = (abs(velocity.y)+100)
		velocity.y += varjumpforce
		print(varjumpforce)
		
func basicmove():

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
