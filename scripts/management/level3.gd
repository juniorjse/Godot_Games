extends GameLevel

onready var boss: KinematicBody2D = get_node("Whale")

export(String) var target_level
export(Vector2) var player_position

func _ready():
	get_tree().call_group("hud", "hide_containers")
	boss.set_physics_process(false)
	player.set_physics_process(false)
	$LevelDesign/cutscene.play("inicial")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player.speed = 0		


func _on_Area2D2_body_entered(body):
	if body.is_in_group("player"):
		player.speed = 0


func _on_ShipPig2_kill():
	player.speed = 120


func _on_ShipPig_kill():
	player.speed = 120


func _on_teleport_body_entered(body):
	if body.is_in_group("player"):
		get_tree().call_group("hud", "hide_containers")
		player.set_physics_process(false)
		$LevelDesign/cutscene.play("final")


func _on_cutscene_animation_finished(anim_name):
	if anim_name == "inicial":
		get_tree().call_group("hud", "normal_state")
		boss.set_physics_process(true)
		player.set_physics_process(true)
	if anim_name == "final":
		boss.set_physics_process(true)
		DataManagement.data_dictionary["current_level_path"] = target_level
		DataManagement.data_dictionary["player_position"] = player_position
		DataManagement.save_data()
		TransitionScreen.fade_in("res://scenes/management/level4.tscn", true)
	
