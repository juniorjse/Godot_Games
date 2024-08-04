extends Area2D

@export var damage: int
@onready var animation: AnimationPlayer = $AnimationPlayer

const SPEED = 250.0

var direction: int = 1
var is_dead: bool = false


func _process(delta):
	if not is_dead:
		position.x += SPEED * delta * direction
	animate()


func animate():
	if is_dead:
		animation.play("dead")
		return
	
	
func _on_body_entered(body):
	is_dead = true
	if not body.name == "Player":
		return
	body.take_damage(damage)


func _on_animation_finished(anim_name):
	if anim_name == "dead":
		queue_free()
		return

