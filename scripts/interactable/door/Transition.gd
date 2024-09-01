extends Area2D

export var target_level: PackedScene


func _on_Transition_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to(target_level)
