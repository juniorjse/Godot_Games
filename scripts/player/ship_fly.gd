extends KinematicBody2D

class_name SHIPFLY

const SPELLs: PackedScene = preload("res://scenes/player/cannon_spell.tscn")

onready var stats: Stats = get_node("Stats")
onready var spell_spawner: Position2D = get_node("Position2D")
onready var left_top_ray: RayCast2D = get_node("LeftTopRay")
onready var right_top_ray: RayCast2D = get_node("RightTopRay")

onready var wall_ray: RayCast2D = get_node("WallRay")

onready var camera: Camera2D = get_node("LevelCamera")
onready var player_sprite: Sprite = get_node("Texture")
onready var collision_area: Area2D = get_node("CollisionArea")

onready var animation: AnimationPlayer = get_node("Animation")

var velocity: Vector2
var spell_offset: Vector2 = Vector2(100, -50)

var direction: int = 1
var jump_count: int = 0
var magic_attack_cost: int = 1

var dead: bool = false
var on_hit: bool = false
var landing: bool = false
var on_wall: bool = false
var flipped: bool = false
var attacking: bool = false
var defending: bool = false
var crouching: bool = false

var can_hide: bool = false
var dialog_on: bool = false
var not_on_wall: bool = true
var can_track_input: bool = true

export(int) var speed
export(int) var jump_speed
export(int) var wall_jump_speed

export(int) var wall_gravity
export(int) var player_gravity
export(int) var wall_impulse_speed

export(NodePath) onready var stats_ref = get_node(stats_ref) as Node

var vertical_velocity: float = 0.0
var gravity: float = 9.8  # Ajuste isso para a gravidade desejada

func _ready() -> void:
	var file = File.new()
	if file.file_exists("user://save.dat"):
		if DataManagement.data_dictionary["checkpoint"]:
			print("Posição do último checkpoint salvo: " + str(DataManagement.data_dictionary["player_position"]))

func _physics_process(_delta: float) -> void:
	if not dialog_on:
		horizontal_movement_env()
		vertical_movement_env()
		actions_env()

		velocity = move_and_slide(velocity, Vector2.UP)
		player_sprite.animate(velocity)

func actions_env() -> void:
	attack()
	crouch()
	defense()

func attack() -> void:
	var attack_condition: bool = not attacking and not crouching and not defending
	if Input.is_action_just_pressed("attack") and attack_condition :
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
	var input_direction: float = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if not can_track_input or attacking:
		velocity.x = 0
		return
		
	velocity.x = input_direction * speed
#
#	if not can_track_input :
#		velocity.x = speed
#		return
#
#	velocity.x =  speed

func vertical_movement_env() -> void:
	if is_on_floor():
		jump_count = 0

	var input_direction_y: float = Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")  # Invertido aqui
	vertical_velocity = input_direction_y * jump_speed  # Ajuste a velocidade de pulo desejada

	if (!can_track_input or attacking) and is_on_floor():
		vertical_velocity = 0

	velocity.y = vertical_velocity

	# Aplicar gravidade
	if !is_on_floor():
		vertical_velocity += gravity * get_physics_process_delta_time()
		velocity.y += vertical_velocity * get_physics_process_delta_time()



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
