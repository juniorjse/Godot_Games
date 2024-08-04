extends GameLevel

export(String) var target_level
export(Vector2) var player_position

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().call_group("hud", "hide_containers")


	player.set_physics_process(false)
	$Interactable/Ship/Camera.current = true
	$cutscene.play("cut")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_cutscene_animation_finished(anim_name):
	if anim_name == "cut":
		get_tree().call_group("hud", "normal_state")
		
		player.set_physics_process(true)
		$Player/LevelCamera.current = true


func _on_final_body_entered(body):
	if body.is_in_group("player"):
			yield(get_tree().create_timer(1.0),"timeout")
			player.set_physics_process(false)
			DataManagement.data_dictionary["current_level_path"] = target_level
			DataManagement.data_dictionary["player_position"] = player_position
			DataManagement.save_data()
			TransitionScreen.fade_in(target_level, true)
		


func _on_came2_body_entered(body):
	if body.is_in_group("player"):
		$LevelCamera2.current = true
