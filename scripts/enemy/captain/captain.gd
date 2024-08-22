extends EnemyTemplate
var attack_animation_suffix: String = "_left"
onready var position_shoot: Position2D = get_node("Position2D")

export(PackedScene) var bullet
export(PackedScene) var bullet2
func _ready() -> void:
	randomize()
	drop_list = {
		"Heal Potion": [
			"res://assets/items/consumable/health_potion.png",
			10,
			"Health",
			5,                                                #Value
			2                                                 
		]
	}
	
	
func verify_position() -> void:
	if player_ref != null:
		var direction: float = sign(player_ref.global_position.x - global_position.x)
		
		if direction > 0:
			texture.flip_h = false
			attack_animation_suffix = "_right"
			floor_ray.position.x = abs(raycast_default_position)
		elif direction < 0:
			texture.flip_h = true
			attack_animation_suffix = "_left"
			floor_ray.position.x = raycast_default_position
			
func spawn_bullet() -> void:
	var projectile: Object = bullet.instance()
	get_tree().root.call_deferred("add_child", projectile)
	projectile.global_position = position_shoot.global_position

