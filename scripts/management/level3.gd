extends GameLevel

onready var enemy: KinematicBody2D = get_node("EnemiesSpawnerList/Crabby")

func _ready():
	get_tree().call_group("hud", "hide_containers")
	
	enemy.set_physics_process(false)
	player.set_physics_process(false)
	$Interactable/Ship/Camera.current = true
	$LevelDesign/cutscene.play("cut")

func _on_cutscene_animation_finished(anim_name):
	if anim_name == "cut":
		get_tree().call_group("hud", "normal_state")
		enemy.set_physics_process(true)
		player.set_physics_process(true)
		$Player/LevelCamera.current = true
