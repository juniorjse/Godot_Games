extends Area2D

@onready var animation = $AnimatedSprite2D

func _on_body_entered(body):
	if !body.name == "Player":
		return
	animation.play("open")
	


func _on_body_exited(body):
	if !body.name == "Player":
		return
	animation.play("close")
