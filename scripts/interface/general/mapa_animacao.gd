extends Control

export(String) var target_level
export(Vector2) var player_position


func _ready():
	$show.play("show")


func _on_show_animation_finished(anim_name):
	if anim_name =="show":
		$anim.play("mapa1")




func _on_anim_animation_finished(anim_name):
	if anim_name == "mapa1":
			DataManagement.data_dictionary["current_level_path"] = target_level
			DataManagement.data_dictionary["player_position"] = player_position
			DataManagement.save_data()
			TransitionScreen.fade_in(target_level, true)
	



