extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -350.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float
var is_attacking: bool

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

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
	if Input.is_action_just_pressed("attack") and not is_attacking:
		attack()

func animate() -> void:
	if is_attacking:
		animation.play("attack")
		return
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

func attack() -> void:
	is_attacking = true
	

func face_toward_movement() -> void:
	if direction < 0:
		sprite.scale.x = -1
	elif direction > 0:
		sprite.scale.x = 1
	
func move() -> void:
	velocity.x = direction * SPEED
	move_and_slide()
	face_toward_movement()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

func jump() -> void:
	velocity.y = JUMP_VELOCITY


func _on_animation_finished(anim_name):
	if anim_name == "attack":
		is_attacking = false
		return
