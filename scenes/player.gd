extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float

@onready var animation: AnimationPlayer = $AnimationPlayer

func _process(delta) -> void:
	animate()

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	move()

func _input(event: InputEvent) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()
	direction = Input.get_axis("move_left", "move_right")

func animate() -> void:
	if velocity.y > 0 and not is_on_floor():
		animation.play("fall")
		return
	if velocity.y < 0 and not is_on_floor():
		animation.play("jump")
		return
	if velocity.x != 0:
		animation.play("run")
		return
	animation.play("idle")

func move() -> void:
	velocity.x = direction * SPEED
	move_and_slide()

	# Rotacionar o personagem baseado na direção
	if direction < 0:
		$Sprite2D.scale.x = -1
	elif direction > 0:
		$Sprite2D.scale.x = 1

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func jump() -> void:
	velocity.y = JUMP_VELOCITY
