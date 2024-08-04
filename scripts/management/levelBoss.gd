extends GameLevel


export(String) var target_level
export(Vector2) var player_position


var reset_target: String = "res://scenes/management/levelBoss.tscn"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Whale.set_physics_process(false)
	$player2/LevelCamera.current = true
	get_tree().call_group("hud", "hide_containers")
	$Player.set_physics_process(false)
	$cutscene.play("cutscene")


func _on_cutscene_animation_finished(anim_name):
	if anim_name =="cutscene":
		
		get_tree().call_group("hud", "normal_state")
		$Player/LevelCamera.current = true
		$Player.set_physics_process(true)
		$Whale.set_physics_process(true)


func _on_primeiracoliso_body_entered(body):
	if body.is_in_group("player"):
		$Player.set_physics_process(false)
		$Whale.set_physics_process(false)
		player.speed = 0 
		$Whale.speed = 0
		$whale.play("whale1")
		


func _on_whale_animation_finished(anim_name):
	if anim_name == "whale1":
		$Player.set_physics_process(true)
		$Whale.set_physics_process(true)
		yield(get_tree().create_timer(10.0), "timeout")
		$Player.set_physics_process(false)
		$Whale.set_physics_process(false)
		$whale.play("whale_apos1")
	if anim_name == "whale_apos1":
		$Player.set_physics_process(true)
		$Whale.set_physics_process(true)
		player.speed = 120
		$Whale.speed = 240


func _on_primeiracoliso2_body_entered(body):
	if body.is_in_group("player"):
		$Player.set_physics_process(false)
		$Whale.set_physics_process(false)
		player.speed = 0 
		$Whale.speed = 0
		$"2fight".play("1")
		


func _on_2fight_animation_finished(anim_name):
	if anim_name == "1":
		$Player.set_physics_process(true)
		$Whale.set_physics_process(true)
		yield(get_tree().create_timer(10.0), "timeout")
		$Player.set_physics_process(false)
		$Whale.set_physics_process(false)
		$"2fight".play("2")
	if anim_name == "2":
		$Player.set_physics_process(true)
		$Whale.set_physics_process(true)
		player.speed = 120
		$Whale.speed = 240


func _on_primeiracoliso3_body_entered(body):
	if body.is_in_group("player"):
		player.speed = 0
		yield(get_tree().create_timer(5.0), "timeout")
		
		TransitionScreen.fade_in(reset_target, false)
	


func _on_Whale_kill():
			player.speed = 0
			DataManagement.data_dictionary["current_level_path"] = target_level
			DataManagement.data_dictionary["player_position"] = player_position
			DataManagement.save_data()
			TransitionScreen.fade_in(target_level, true)
		


func _on_primeiracoliso4_body_entered(body):
	if body.is_in_group("player"):
		$Player.set_physics_process(false)
		$Whale.set_physics_process(false)
		player.speed = 0 
		$Whale.speed = 0
		$final.play("final1")


func _on_final_animation_finished(anim_name):
	if anim_name == "final1":
		$Player.set_physics_process(true)
		$Whale.set_physics_process(true)
		yield(get_tree().create_timer(10.0), "timeout")
		$Player.set_physics_process(false)
		$Whale.set_physics_process(false)
	
		$final.play("final2")
	if anim_name == "final2":
		$Player.set_physics_process(true)
		$Whale.set_physics_process(true)
		player.speed = 120
		$Whale.speed = 240
		
