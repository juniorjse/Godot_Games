extends TextureProgressBar


# Called when the node enters the scene tree for the first time.
func _ready():
	var player: Player = get_tree().current_scene.get_node("Player")
	player.health_changed.connect(_on_health_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_health_changed(current_health: int, max_health: int):
	value = current_health * 100 / max_health
