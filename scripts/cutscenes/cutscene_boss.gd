extends Node2D

export(String) var target_level
export(Vector2) var player_position
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$cutscene.play("inicial")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_cutscene_animation_finished(anim_name):
	if anim_name == "inicial":
				DataManagement.data_dictionary["current_level_path"] = target_level
				DataManagement.data_dictionary["player_position"] = player_position
				DataManagement.save_data()
				TransitionScreen.fade_in(target_level, true)
