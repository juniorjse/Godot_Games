extends GameLevel

export(String) var target_level
export(Vector2) var player_position

func _on_cam_body_entered(body):
	if body.is_in_group("player"):
		$LevelCamera.current = true

func _on_teleport_body_entered(body):
	if body.is_in_group("player"):
			
			yield(get_tree().create_timer(0.60),"timeout")
			player.set_physics_process(false)
			DataManagement.data_dictionary["current_level_path"] = target_level
			DataManagement.data_dictionary["player_position"] = player_position
			DataManagement.save_data()
			TransitionScreen.fade_in(target_level, true)
