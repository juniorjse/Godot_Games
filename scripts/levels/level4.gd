extends GameLevel
export(String) var target_level
export(Vector2) var player_position


func _ready():
	$LevelDesign/sound_back.play()
	get_tree().call_group("hud", "hide_containers")
	player.set_physics_process(false)
	$Interactable/Ship/Camera.current = true
	$cutscene.play("cut")


func _on_cutscene_animation_finished(anim_name):
	if anim_name == "cut":
		get_tree().call_group("hud", "normal_state")
		player.set_physics_process(true)
		$Player/LevelCamera.current = true


func _on_teleport_body_entered(body):
	if body.is_in_group("player"):
		$LevelCamera2.current = true


func _on_teleport2_body_entered(body):
	if body.is_in_group("player"):
		DataManagement.data_dictionary["current_level_path"] = target_level
		DataManagement.data_dictionary["player_position"] = player_position
		DataManagement.save_data()
		TransitionScreen.fade_in(target_level, true)
