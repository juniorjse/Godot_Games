extends StaticBody2D

#const CANNON_BALL_SCENE = preload("res://scenes/enemies/cannons/cannonball/cannon_ball.tscn")
const CANNON_BALL_SCENE = preload("res://scenes/enemies/cannon/cannon_ball/cannon_ball.tscn")
#A oura é uada, vou usar a primeira
const LINE_OF_SIGHT_TARGET_POSITION: int = -200

@onready var line_of_sight = $LineOfSight
@onready var animation = $AnimationPlayer
@onready var cannon_ball_spawn_position = $CannonBallSpawnPosition
@onready var attack_cooldown = $AttackCooldown
@onready var sprite = $Sprite2D

@export var faceing_left: bool = true

var is_attacking: bool = false
var can_attack: bool = true
# Called when the node enters the scene tree for the first time.
func _ready():
	if not faceing_left:
		sprite.flip_h = true
		line_of_sight.target_position.x = -LINE_OF_SIGHT_TARGET_POSITION
		return
	if faceing_left:
		sprite.flip_h = false
		line_of_sight.target_position.x = LINE_OF_SIGHT_TARGET_POSITION
		return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animate()

func _physics_process(delta):
	check_line_of_sight()

func instantiate_cannon_ball():
	var direction: int = -1 if faceing_left else 1
	attack_cooldown.start()
	can_attack = false
	var cannon_ball = CANNON_BALL_SCENE.instantiate()
	cannon_ball.global_position = cannon_ball_spawn_position.global_position
	get_parent().add_child(cannon_ball)
	cannon_ball.direction = direction

func animate():
	if is_attacking:
		animation.play("attack")

func check_line_of_sight():
	if !can_attack:
		return
	if line_of_sight.is_colliding() and !is_attacking:
		is_attacking = true
	
func _on_animation_finished(anim_name):
	if anim_name == "attack":
		is_attacking = false
		return

func _on_attack_cooldown_timeout():
	can_attack = true
