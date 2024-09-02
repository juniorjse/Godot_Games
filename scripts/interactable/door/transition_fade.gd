class_name TransitionFade
extends CanvasLayer

func transition_to_scene(target_level: PackedScene) -> void:
	get_tree().change_scene_to(target_level)
