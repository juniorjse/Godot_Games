extends Area2D



onready var animation = $AnimatedSprite


func _ready():
	animation.play("idle")


func _on_Door_body_entered(body):
	if body.name == "Player":
		animation.play("open")


func _on_Door_body_exited(body):
	if body.name == "Player":
		animation.play("close")
