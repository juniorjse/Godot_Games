extends Area2D
var direction: int = -1
export(int) var damage
onready var sprite: Sprite = get_node("Texture")
onready var anim: AnimationPlayer = get_node("anim")
export(int) var speed

	
func _ready() -> void:
	anim.play("idle")

		
func _physics_process(_delta: float) -> void:
	translate(Vector2(speed * direction, 0))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_cannon_ball_body_entered(body):
	if body.is_in_group("player") or body.is_in_group("tile"):
		get_tree().call_group("player_stats", "update_health", "Decrease", damage)
		queue_free()
	
		


func _on_anim_animation_finished(anim_name):
	if anim_name == "idle":
		yield(get_tree().create_timer(1.0),"timeout")
	else:
			return
