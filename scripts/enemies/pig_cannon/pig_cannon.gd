extends EnemyTemplate



onready var position_shoot: Position2D = get_node("Position2D")


export(PackedScene) var bullet


func _ready() -> void:

	randomize()
	drop_list = {
		"Heal Potion": [
			"res://assets/items/consumable/simple_orb.png", #Image Path Type
			100,                                               #Drop Probability
			"Health",                                         #Type
			5,                                                #Value
			2,                                                #Sell Price
		], 
		
	}


	
func verify_position() -> void:
	if player_ref != null:
		var direction: float = sign(player_ref.global_position.x - global_position.x)
		
		if direction > 0:
			
			
			floor_ray.position.x = abs(raycast_default_position)
		elif direction < 0:
			
			
			floor_ray.position.x = raycast_default_position
func spawn_effect(effect_path: String, offset: Vector2, is_flipped: bool) -> void:
	var effect_instance = load(effect_path).instance()
	get_tree().root.call_deferred("add_child", effect_instance)
	if is_flipped:
		effect_instance.flip_h = true
		
	effect_instance.global_position = global_position + offset
	effect_instance.play_effect()

func spawn_bullet() -> void:
	var projectile: Object = bullet.instance()
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = position_shoot.global_position

