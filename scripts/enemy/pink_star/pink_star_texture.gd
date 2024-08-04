extends EnemyTexture
class_name PinkStarTexture

func animate(velocity: Vector2) -> void:
	if enemy_ref.can_attack or enemy_ref.can_hit or enemy_ref.can_die:
		action_behavior()
	else:
		move_behavior(velocity)
		
		
func action_behavior() -> void:
	if enemy_ref.can_die:
		animation.play("dead")
		enemy_ref.can_hit = false
		enemy_ref.can_attack = false
		
	elif enemy_ref.can_hit:
		animation.play("hit")
		enemy_ref.can_attack = false
		
	elif enemy_ref.can_attack:
		animation.play("attack_anticipation")
		enemy_ref.set_physics_process(false)
		
		
func move_behavior(velocity: Vector2) -> void:
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
		
		
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"attack_left":
			enemy_ref.can_attack = false
			enemy_ref.set_physics_process(true)
			
		"attack_right":
			enemy_ref.can_attack = false
			enemy_ref.set_physics_process(true)
			
		"hit":
			enemy_ref.can_hit = false
			enemy_ref.set_physics_process(true)
			
		"dead":
			DataManagement.score += score
			enemy_ref.kill_enemy()
			
		"kill":
			enemy_ref.queue_free()
			
		"attack_anticipation":
			animation.play("attack" + enemy_ref.attack_animation_suffix)
