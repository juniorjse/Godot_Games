extends GameLevel
export(String) var target_level
export(Vector2) var player_position

func _ready():
	get_tree().call_group("hud", "hide_containers")
	player.set_physics_process(false)
	$cutscene.play("cutscene")


func _on_cutscene_animation_finished(anim_name):
	if anim_name == "cutscene":
		player.set_physics_process(true)
		get_tree().call_group("hud", "normal_state")
	if anim_name == "final":
			DataManagement.data_dictionary["current_level_path"] = target_level
			DataManagement.data_dictionary["player_position"] = player_position
			DataManagement.save_data()
			TransitionScreen.fade_in(target_level, true)
func _on_cutscene_final_body_entered(body):
	if body.is_in_group("player"):
		get_tree().call_group("hud", "hide_containers")
		player.set_physics_process(false)
		$cutscene.play("final")
		
