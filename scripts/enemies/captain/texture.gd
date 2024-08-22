extends EnemyTexture

var mapa_scene: PackedScene

func _ready():
	mapa_scene = load("res://scenes/interactable/coletaveis/map.tscn")
	if mapa_scene:
		print("MAPA CARREGADO")
	else:
		print("Erro: Não foi possível carregar o mapa.")

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
		animation.play("attack" + enemy_ref.attack_animation_suffix)
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
			if mapa_scene:
				var mapa_instance = mapa_scene.instance()
				mapa_instance.global_position = self.global_position
				get_parent().add_child(mapa_instance)
				print("Mapa instanciado na posição: ", mapa_instance.global_position)
				print("Mapa adicionado ao pai: ", get_parent().name)
				mapa_instance.visible = true
			else:
				print("Erro: mapa_scene é null.")
			enemy_ref.queue_free()
		"kill":
			enemy_ref.queue_free()

func _on_Timer_timeout():
	enemy_ref.can_attack = true
