extends Control

export(String) var target_level
export(Vector2) var player_position


func _ready():
	$dialog/cutscene.play("figura")


func _on_cutscene_animation_finished(_anim_name):
				DataManagement.data_dictionary["current_level_path"] = target_level
				DataManagement.data_dictionary["player_position"] = player_position
				DataManagement.save_data()
				TransitionScreen.fade_in(target_level, true)
