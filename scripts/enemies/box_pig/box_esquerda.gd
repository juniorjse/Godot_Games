extends Area2D

export(int) var damage = 10
export(int) var speed = 90
export(int) var initial_jump_velocity = 150
export(int) var gravit = 500

var direction: int = -1
var velocity: Vector2 = Vector2(speed * direction, -initial_jump_velocity)

onready var sprite: Sprite = $Texture
onready var anim: AnimationPlayer = $anim

func _ready() -> void:
	anim.play("idle")

func _physics_process(_delta: float) -> void:
	velocity.y += gravit * _delta
	translate(velocity * _delta)

	# Verifique se a velocidade horizontal é muito pequena e a defina como zero
	if abs(velocity.x) < 0.1:
		velocity.x = 0

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_cannon_ball_body_entered(body):
	if body.is_in_group("player"):
		get_tree().call_group("player_stats", "update_health", "Decrease", damage)
		anim.play("slice")
		velocity.x = 0
		velocity.y = -120
	
	if body.is_in_group("tile"):
		anim.play("slice")
		velocity.x = 0
		velocity.y = -120
func _on_anim_animation_finished(anim_name):
	if anim_name == "slice":
		queue_free()
