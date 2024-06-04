extends CharacterBody2D
class_name Player

@export var max_health: int

const SPEED = 200.0
const JUMP_VELOCITY = -350.0
const ATTACK_COLLISION_SHAPE_OFFSET: int = 22

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: float
var is_attacking: bool
var is_taking_damage: bool
var current_health: int 
var is_dead: bool

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var attack_collision_shape: CollisionShape2D = $Area2D/AttackCollisionShape2D

signal health_changed(current_health: int, max_health: int)
	

func _ready():
	current_health = max_health

func _process(delta) -> void:
	animate()

func _physics_process(delta: float) -> void:
	if is_dead:
		return
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
	if is_dead:
		animation.play("dead")
		return
	if is_taking_damage:
		animation.play("hit")
		return
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
		attack_collision_shape.position.x = -ATTACK_COLLISION_SHAPE_OFFSET
	elif direction > 0:
		sprite.scale.x = 1
		attack_collision_shape.position.x = ATTACK_COLLISION_SHAPE_OFFSET
	
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
	if anim_name == "hit":
		is_taking_damage = false
		return
	if anim_name == "dead":
		get_tree().reload_current_scene()
		return

func take_damage(damage_amount: int):
	current_health -= damage_amount
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		is_dead = true
	else:
		is_taking_damage = true
