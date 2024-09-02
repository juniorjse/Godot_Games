extends Control


func _ready() -> void:
	var _start: bool = TransitionScreen.connect("start", self, "start_game")
	#$transition_fade/AnimationPlayer2.play("fade_in")
	
func start_game() -> void:
	$GameMenu/Animation.play("show_container")
	
	
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"show_container":
			$GameMenu/InitialContainer.connect_buttons()


func _on_Button_pressed():
	get_tree().quit()
