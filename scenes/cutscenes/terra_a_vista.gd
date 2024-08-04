extends Control
export(String) var target_level
export(Vector2) var player_position

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("mapa")
	$Level/LevelCamera.current = true
	

func _on_anim_animation_finished(anim_name):
	if anim_name == "mapa":
			DataManagement.data_dictionary["current_level_path"] = target_level
			DataManagement.data_dictionary["player_position"] = player_position
			DataManagement.save_data()
			TransitionScreen.fade_in(target_level, true)
