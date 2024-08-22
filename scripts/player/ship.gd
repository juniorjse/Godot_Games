extends Player


const SPELLs: PackedScene = preload("res://scenes/player/cannon_spell.tscn")




onready var spell_spawner: Position2D = get_node("Position2D")


func _ready() -> void:
	var file = File.new()
	if file.file_exists("user://save.dat"):
		if DataManagement.data_dictionary["checkpoint"]:
			print("Posição do último checkpoint salvo: " + str(DataManagement.data_dictionary["player_position"]))
			
		
		
func _physics_process(delta: float) -> void:
	if not dialog_on:
		horizontal_movement_env()
		vertical_movement_env()
		actions_env()
		
	gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	player_sprite.animate(velocity)
	
	
func actions_env() -> void:
	attack()
	crouch()
	defense()
	
	
func attack() -> void:
	var attack_condition: bool = not attacking and not crouching and not defending
	if Input.is_action_just_pressed("attack") and attack_condition and is_on_floor():
		attacking = true
		player_sprite.normal_attack = true
	elif Input.is_action_just_pressed("magic_attack") and attack_condition and is_on_floor() and stats.current_mana >= magic_attack_cost:
		attacking = true
		player_sprite.magic_attack = true
		stats.update_mana("Decrease", magic_attack_cost)
		
		
func crouch() -> void:
	if Input.is_action_pressed("ui_down") and is_on_floor() and not defending:
		crouching = true
		defending = false
		can_track_input = false
		stats_ref.shielding = false
	elif not defending:
		crouching = false
		can_track_input = true
		stats_ref.shielding = false
		player_sprite.crouching_off = true
		
		
func defense() -> void:
	if Input.is_action_pressed("defense") and is_on_floor() and not crouching:
		defending = true
		crouching = false
		can_track_input = false
		stats_ref.shielding = true
	elif not crouching:
		defending = false
		can_track_input = true
		stats_ref.shielding = false
		player_sprite.shield_off = true
		
		
func horizontal_movement_env() -> void:
	
	if not can_track_input :
		velocity.x = 0
		return
		
	velocity.x = speed #COLOCAR SPEED NO LUGAR DO ZERO
	
	
func vertical_movement_env() -> void:
	if is_on_floor():
		jump_count = 0
		
	if Input.is_action_just_pressed("ui_select") and jump_count < 2 and can_track_input and not attacking:
		
		jump_count += 1
		spawn_effect("res://scenes/effects/dust/jump_effect.tscn", Vector2(0, 5), flipped)
		if next_to_wall() and not is_on_floor():
			velocity.y = wall_jump_speed
			velocity.x += wall_impulse_speed * direction
		else:
			velocity.y = jump_speed
			
			
func gravity(delta: float) -> void:
	if next_to_wall():
		velocity.y += wall_gravity * delta
		if velocity.y >= wall_gravity:
			velocity.y = wall_gravity
			
	else:
		velocity.y += player_gravity * delta
		if velocity.y >= player_gravity:
			velocity.y = player_gravity
			
			
func next_to_wall() -> bool:
	if (left_top_ray.is_colliding() or right_top_ray.is_colliding()) and not is_on_floor():
		landing = false
		
	if wall_ray.is_colliding() and not is_on_floor():
		if not_on_wall:
			velocity.y = 0
			not_on_wall = false
			
		return true
		
	else:
		not_on_wall = true
		return false
		
		
func reset(state: bool) -> void:
	velocity.x = 0
	dialog_on = state
	
	landing = false
	on_wall = false
	attacking = false
	defending = false
	crouching = false
	
	
func spawn_effect(effect_path: String, offset: Vector2, is_flipped: bool) -> void:
	var effect_instance = load(effect_path).instance()
	get_tree().root.call_deferred("add_child", effect_instance)
	if is_flipped:
		effect_instance.flip_h = true
		
	effect_instance.global_position = global_position + offset
	effect_instance.play_effect()
	
	
func spawn_spell() -> void:
	var shoot: FireSpell = SPELLs.instance()
	shoot.spell_damage = stats.base_attack + stats.bonus_attack
	shoot.global_position = spell_spawner.global_position
	shoot.direction = self.direction
	get_tree().root.call_deferred("add_child", shoot)

func hide_player() -> void:
	camera.drag_margin_h_enabled = false
	camera.drag_margin_v_enabled = false
	can_hide = true
