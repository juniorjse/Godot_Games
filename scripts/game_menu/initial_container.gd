extends Control
class_name InitialContainer

onready var buttons_container: VBoxContainer = get_node("ButtonsContainer")
onready var continue_button = $ButtonsContainer/Continue

var can_click: bool = false
var target_level_path: String = "res://scenes/management/level.tscn"

export(NodePath) onready var animation = get_node(animation) as AnimationPlayer

func connect_buttons() -> void:
	for button in buttons_container.get_children():
		button.connect("pressed", self, "on_button_pressed", [button])
		button.connect("mouse_exited", self, "mouse_interaction", [button, "exited"])
		button.connect("mouse_entered", self, "mouse_interaction", [button, "entered"])
		
	has_save()
func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"entered":
			can_click = true
			button.modulate.a = .5
				
		"exited":
			can_click = false
			button.modulate.a = 1.0
			
func has_save() -> void:
	
	var file: File = File.new()
	if file.file_exists(DataManagement.save_path):
		continue_button.disabled = false
		return
	continue_button.modulate.a = 0.5
func on_button_pressed(button: Button) -> void:
	match button.name:
		"NewGame":
			get_tree().change_scene(target_level_path)
		"Continue":
			DataManagement.load_data()
			get_tree().change_scene(DataManagement.data_dictionary.current_level_path)
		"Quit":
			get_tree().quit()
				
func reset() -> void:
	for button in get_tree().get_nodes_in_group("button"):
		mouse_interaction(button, "exited")
		
	has_save()
