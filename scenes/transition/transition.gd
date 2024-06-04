class_name Transition
extends CanvasLayer


@onready var animation = $AnimationPlayer

func _ready():
	animation.play("fade_in")

func transition_scene(target_scene: PackedScene):
	animation.play("fade_out")
	get_tree().change_scene_to_packed(target_scene)
	animation.play("fade_in")
