extends KinematicBody2D
signal kill

const FLOATING_TEXT: PackedScene = preload("res://scenes/enviroment/floating_text.tscn")
const PHYSIC_ITEM: PackedScene = preload("res://scenes/props/interactable/physic_item.tscn")

onready var texture: Sprite = get_node("Texture")
onready var floor_ray: RayCast2D = get_node("FloorRay")
onready var animation: AnimationPlayer = get_node("Animation")

var drop_bonus: int

var can_die: bool = false
var can_hit: bool = false
var can_attack: bool = false

var velocity: Vector2
var drop_list: Dictionary
var player_ref: KinematicBody2D = null

export(int) var damage

export(int) var speed
export(int) var enemy_exp
export(int) var gravity_speed
export(int) var proximity_threshold
export(int) var raycast_default_position

export(float) var attack_cooldown

func _physics_process(_delta: float) -> void:
	
	move_behavior()
	verify_position()
	texture.animate(velocity)
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func move_behavior() -> void:
	if player_ref != null:
		var distance: Vector2 = player_ref.global_position - global_position
		var direction: Vector2 = distance.normalized()
		if abs(distance.x) <= proximity_threshold:
			velocity.x = direction.x * speed
			can_attack = true
		
	
	


	
	

			
func kill_enemy() -> void:
	animation.play("kill")
	get_tree().call_group("player_stats", "update_exp", enemy_exp)
#	spawn_item_probability()
	emit_signal("kill")
	
	
func spawn_item_probability() -> void:
	get_tree().call_group("hud", "spawn_dice", self)
	
	
func get_dice_value(dice: int) -> void:
	print("Dice Value: " + str(dice))
	
	if dice <= 6:
		drop_bonus = 1
	elif dice >= 7 and dice <= 13:
		drop_bonus = 2
	else:
		drop_bonus = 3
		
	print("Drop Multiplier: " + str(drop_bonus))
	
	for key in drop_list.keys():
		var random_number: int = randi() % 100 + 1
		print(drop_list[key][1] * drop_bonus)
		if random_number <= drop_list[key][1] * drop_bonus:
			var item_texture: StreamTexture = load(drop_list[key][0])
			var item_info: Array = [drop_list[key][0], drop_list[key][2], drop_list[key][3], drop_list[key][4], 1]
			spawn_physic_item(key, item_texture, item_info)
			
			
func spawn_floating_text(type_sign: String, type: String, value: int) -> void:
	var text: FloatText = FLOATING_TEXT.instance()
	get_tree().root.call_deferred("add_child", text)
	
	text.rect_global_position = global_position
	text.type = type
	text.value = value
	text.type_sign = type_sign
	
	
func spawn_physic_item(key: String, item_texture: StreamTexture, item_info: Array) -> void:
	var item: PhysicItem = PHYSIC_ITEM.instance()
	get_tree().root.call_deferred("add_child", item)
	item.global_position = global_position
	item.update_item_info(key, item_texture, item_info)

var attack_animation_suffix: String = "_left"
onready var position_shoot: Position2D = get_node("Position2D")
onready var position_shoot2: Position2D = get_node("Position2D2")
export(PackedScene) var bullet
export(PackedScene) var bullet2
func _ready() -> void:
	$moviment.play("mov")
	randomize()
	drop_list = {
		"Heal Potion": [
			"res://assets/items/consumable/health_potion.png", #Image Path Type
			25,                                               #Drop Probability
			"Health",                                         #Type
			5,                                                #Value
			2                                                 #Sell Price
		], 
		
		"Mana Potion": [
			"res://assets/items/consumable/mana_potion.png", 
			12, 
			"Mana", 
			5, 
			5
		],
		
		"Pink Star Mouth": [
			"res://assets/items/resource/pink_star/pink_star_mouth.png",
			47,
			"Resource",
			{},
			5
		],
		
		"Pink Star Bow": [
			"res://assets/items/equipment/pink_star_bow.png",
			1,
			"Weapon",
			{
				"Attack": 5
			},
			60
		],
		
		"Pink Star Belt": [
			"res://assets/items/equipment/pink_star_belt.png",
			3, 
			"Equipment",
			{
				"Health": 5,
				"Mana": 5
			},
			40
		],
		
		"Pink Star Shield": [
			"res://assets/items/equipment/pink_star_shield.png",
			1,
			"Weapon",
			{
				"Health": 3,
				"Defense": 2
			},
			75
		]
	}
	
	
func verify_position() -> void:
	if player_ref != null:
		var direction: float = sign(player_ref.global_position.x - global_position.x)
		
		if direction > 0:
			texture.flip_h = true
			attack_animation_suffix = "_right"
			floor_ray.position.x = abs(raycast_default_position)
		elif direction < 0:
			texture.flip_h = false
			attack_animation_suffix = "_left"
			floor_ray.position.x = raycast_default_position
func spawn_bullet() -> void:
	var projectile: Object = bullet.instance()
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = position_shoot.global_position
func spawn_bullet2() -> void:
	var projectile: Object = bullet2.instance()
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = position_shoot2.global_position

