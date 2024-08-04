extends ParallaxBackground

export(bool) var can_process
export(Array, int) var layer_speed

func _ready() -> void:
	pass
		
		
func _physics_process(delta: float) -> void:
	for index in get_child_count():
		if get_child(index) is ParallaxLayer:
			get_child(index).motion_offset.x -= delta * layer_speed[index]
