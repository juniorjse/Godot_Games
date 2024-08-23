extends Control

const LEVEL_01 = preload("res://scenes/levels/level_01.tscn")
func _on_play_button_pressed():
	GlobalTransition.transition_scene(LEVEL_01)


func _on_quit_button_pressed():
	get_tree().quit()
