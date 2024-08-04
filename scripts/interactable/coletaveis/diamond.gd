extends Area2D
class_name Tesouro
export var score = 1
signal pegou_map

func _on_coletaveis_body_entered(_body: Node) -> void:
	$anim.play("colected")

	DataManagement.score += score
	DataManagement.data_dictionary["score"] = score
	DataManagement.save_data()

func _on_anim_animation_finished(anim_name):
	if anim_name == "colected":
		emit_signal("pegou_map")
		queue_free()
