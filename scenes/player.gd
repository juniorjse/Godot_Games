extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float


func _physics_process(delta):
	#apply_gravity(delta)
	move()


func _input(event):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	direction = Input.get_axis("move_left", "move_right")
		


func move() -> void:
	velocity.x = direction * SPEED
	move_and_slide()


func apply_gravity(delta) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


func jump() -> void:
	velocity.y = JUMP_VELOCITY
