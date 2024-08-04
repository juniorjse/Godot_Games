extends EnemyTemplate
var attack_animation_suffix: String = "_left"
onready var position_shoot: Position2D = get_node("Position2D")
onready var position_shoot2: Position2D = get_node("Position2D2")
export(PackedScene) var bullet
export(PackedScene) var bullet2
func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Potion": [
			"res://assets/item/consumable/health_potion.png", #Image Path Type
			25,                                               #Drop Probability
			"Health",                                         #Type
			5,                                                #Value
			2                                                 #Sell Price
		], 
		
		"Mana Potion": [
			"res://assets/item/consumable/mana_potion.png", 
			12, 
			"Mana", 
			5, 
			5
		],
		
		"Pink Star Mouth": [
			"res://assets/item/resource/pink_star/pink_star_mouth.png",
			47,
			"Resource",
			{},
			5
		],
		
		"Pink Star Bow": [
			"res://assets/item/equipment/pink_star_bow.png",
			1,
			"Weapon",
			{
				"Attack": 5
			},
			60
		],
		
		"Pink Star Belt": [
			"res://assets/item/equipment/pink_star_belt.png",
			3, 
			"Equipment",
			{
				"Health": 5,
				"Mana": 5
			},
			40
		],
		
		"Pink Star Shield": [
			"res://assets/item/equipment/pink_star_shield.png",
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

