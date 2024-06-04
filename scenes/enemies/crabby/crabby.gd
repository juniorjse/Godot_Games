extends CharacterBody2D

@export var damage: int
@export var max_health: int

@onready var animation = $AnimationPlayer
@onready var attack_left_raycast = $AttackLeft
@onready var attack_right_raycast = $AttackRight
@onready var ground_check_raycast = $GroundCheck
@onready var attack_coldown_timer = $AttackColdownTimer
@onready var attack_area = $AttackArea # Certifique-se de que esta seja a área de ataque correta

const SPEED = 25.0
signal health_changed(current_health: int, max_health: int)

var is_dead: bool = false
var is_taking_damage: bool = false
var is_attacking: bool = false
var is_charging: bool = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: int = 1
var current_health: int

func _ready():
	current_health = max_health
	animation.connect("animation_finished", Callable(self, "_on_animation_finished"))
	attack_area.connect("body_entered", Callable(self, "_on_attack_area_body_entered")) # Conecte o sinal aqui

func _process(delta):
	animate()

func _physics_process(delta):
	apply_gravity(delta)
	patrol()
	check_attack_range()

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func patrol():
	ground_check()
	velocity.x = SPEED * direction
	move_and_slide()
	
func ground_check():
	if not ground_check_raycast.is_colliding():
		change_direction()
	else:
		return

func check_attack_range():
	if not attack_coldown_timer.is_stopped():
		return
	if is_attacking:
		return
	if is_charging:
		return
	if attack_left_raycast.is_colliding() or attack_right_raycast.is_colliding():
		is_charging = true
		change_direction()

func change_direction():
	direction *= -1
	update_ground_check_position()

func update_ground_check_position():
	if direction == 1:
		ground_check_raycast.position.x = abs(ground_check_raycast.position.x)
	else:
		ground_check_raycast.position.x = -abs(ground_check_raycast.position.x)

func animate():
	if is_dead:
		animation.play("dead")
		return
	if is_taking_damage:
		animation.play("hit")
		return
	if is_charging:
		animation.play("antecipacion")
		attack_coldown_timer.start()
		return
	if is_attacking:
		animation.play("attack")
		return
	if velocity.x != 0:
		animation.play("run")
		return
	animation.play("idle")

func _on_animation_finished(anim_name):
	if anim_name == "antecipacion":
		is_charging = false
		is_attacking = true
		return
	if anim_name == "attack":
		is_attacking = false
		is_charging = false
		return

func _on_attack_area_body_entered(body):
	if not body.has_method("take_damage"):
		return
	body.take_damage(damage)
	change_direction()

func take_damage(damage_amount: int):
	current_health -= damage_amount
	health_changed.emit(current_health, max_health)
	if current_health <= 0:
		is_dead = true
	else:
		is_taking_damage = true
