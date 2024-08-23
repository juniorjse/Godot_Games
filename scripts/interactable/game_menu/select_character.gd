extends Control
class_name SelectCharacter

onready var character_container: HBoxContainer = get_node("CharacterSelectContainer")

var can_click: bool = false
var target_level_path: String = "res://scenes/levels/level.tscn"

func connect_buttons() -> void:
	for container in character_container.get_children():
		var button: Button = container.get_child(1)
		var _exited: bool = button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		var _entered: bool = button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
		var _pressed: bool = button.connect("pressed", self, "on_button_pressed", [button])
		
		
func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"entered":
			can_click = true
			button.modulate.a = .5
			
		"exited":
			can_click = false
			button.modulate.a = 1.0
			
			
func on_button_pressed(button: Button) -> void:
	

	match button.name:
			"Blue":
				send_skin_and_start_game()
		
	
		
func reset(button: Button) -> void:
	button.modulate.a = .2
	yield(get_tree().create_timer(.1), "timeout")
	if not can_click:
		button.modulate.a = 1.0
	else:
		button.modulate.a = .5
		
		
func send_skin_and_start_game() -> void:
	DataManagement.data_dictionary["current_level_path"] = target_level_path
	
	DataManagement.save_data()
	
	TransitionScreen.fade_in(target_level_path, false)


func _on_Blue_mouse_entered():
	modulate.a = .5
	$CharacterSelectContainer/Blue/Texture.modulate.a = .5


func _on_Blue_mouse_exited():
	modulate.a = 1
	$CharacterSelectContainer/Blue/Texture.modulate.a = 1
