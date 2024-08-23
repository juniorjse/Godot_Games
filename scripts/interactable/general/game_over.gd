extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


	

func _on_Button_pressed():
	var _change_scene = get_tree().change_scene(DataManagement.data_dictionary.current_level_path)
	DataManagement.load_data()


func _on_Button_mouse_entered():
	$Button.modulate.a = 0.5
	


func _on_Button_mouse_exited():
	$Button.modulate.a = 1


func _on_anim_animation_finished(_anim_name):
	$Button.grab_focus()


func _on_Mapa_pressed():
	pass # Replace with function body.
