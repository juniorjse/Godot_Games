extends EnemyTexture
class_name WhaleTexture

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
		animation.play("attack")
		
		
func move_behavior(velocity: Vector2) -> void:
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")
		
		
func on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"attack":
			enemy_ref.can_attack = false
			enemy_ref.set_physics_process(true)
			
		"hit":
			enemy_ref.can_hit = false
			enemy_ref.set_physics_process(true)
			
		"dead":
			enemy_ref.kill_enemy()
			
		"kill":
			DataManagement.score += score
			enemy_ref.queue_free()
