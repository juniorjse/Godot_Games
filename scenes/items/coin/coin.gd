extends Area2D

@onready var animation = $AnimationPlayer

signal coin_collected()

func _ready():
	animation.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _on_body_entered(body):
	animation.play("pickup")
	coin_collected.emit()

func _on_animation_finished(anim_name):
	if anim_name == "pickup":
		queue_free()
