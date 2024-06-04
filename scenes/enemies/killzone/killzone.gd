extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		body.is_dead = true
		return
	queue_free()
