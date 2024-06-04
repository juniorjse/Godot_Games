extends StaticBody2D

const CANNON_BALL_SCENE = preload("res://scenes/enemies/cannon/cannon_ball/cannon_ball.tscn")
const LINE_OF_SIGHT_TARGET_POSITION: int = -200

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var line_of_sight: RayCast2D = $LineOfSight
@onready var ball_spawn: Marker2D = $BallSpawn
@onready var timer: Timer = $Timer
@onready var sprite: Sprite2D = $Sprite2D

@export var facing_left: bool = true
@export var max_health: int
@export var damage: int

var is_attacking: bool = false
var can_attack: bool = true
var is_dead: bool = false
var current_health: int
var is_taking_damage: bool = false

signal health_changed(current_health: int, max_health: int)

func _ready():
	current_health = max_health
	if !facing_left:
		sprite.flip_h = true
		line_of_sight.target_position.x = -LINE_OF_SIGHT_TARGET_POSITION
	else:
		sprite.flip_h = false
		line_of_sight.target_position.x = LINE_OF_SIGHT_TARGET_POSITION

func _process(delta):
	animate()

func _physics_process(delta):
	check_line_of_sight()

func check_line_of_sight():
	if line_of_sight.is_colliding() and can_attack and not is_attacking and not is_dead:
		is_attacking = true
	
func animate():
	if is_dead:
		animation.play("dead")
		queue_free()  # Remove o canhão da cena quando a animação de morte é reproduzida
		return
	if is_taking_damage:
		animation.play("hit")
		is_taking_damage = false  # Reset após a animação de hit
		return
	if is_attacking:
		animation.play("attack")

func instantiate_cannon_ball():
	var direction = -1 if facing_left else 1
	
	timer.start()
	can_attack = false
	var cannon_ball = CANNON_BALL_SCENE.instantiate()
	cannon_ball.global_position = ball_spawn.global_position
	get_parent().add_child(cannon_ball)
	cannon_ball.direction = direction

func _on_animation_finished(anim_name):
	if anim_name == "attack":
		is_attacking = false

func _on_timer_timeout():
	can_attack = true
	
func take_damage(damage_amount: int):
	current_health -= damage_amount
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		is_dead = true
	else:
		is_taking_damage = true
