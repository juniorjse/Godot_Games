extends Area2D
class_name FireSpell

var spell_damage: int

func _ready() -> void:
	yield(get_tree().create_timer(0.10), "timeout")
	$anim.play("charge")
			
			
func on_animation_finished(_anim_name: String) -> void:
	queue_free()


func _on_anim_animation_finished(anim_name):
	if anim_name == "charge":
		$anim.play("boom")
	if anim_name == "boom":
		queue_free()
