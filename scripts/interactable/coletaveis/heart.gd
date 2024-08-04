extends Area2D

var health = 5
signal pegou_map

func _on_coletaveis_body_entered(_body: Node) -> void:
	get_tree().call_group("player_stats", "update_health", "Increase", health)
	$anim.play("colected")
	
	

func _on_anim_animation_finished(anim_name):
	if anim_name == "colected":
		emit_signal("pegou_map")
		queue_free()


