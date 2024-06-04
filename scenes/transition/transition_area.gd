extends Area2D

@export var next_scene: PackedScene

func _on_body_entered(body):
	if !body.name == "Player":
		return
	GlobalTransition.transition_scene(next_scene)
