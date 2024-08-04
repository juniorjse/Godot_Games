extends FireSpell
class_name Canhao
var speed = 600

 # Ajuste a velocidade conforme necessário
var direction: int = 1
func _ready() -> void:
	$anim.play("boom")
	
func _process(delta: float) -> void:
	# Mova o projétil para a direita a cada frame
	var move_vector = Vector2(speed * delta, 0)
	translate(move_vector)
	
func on_animation_finished(_anim_name: String) -> void:
	queue_free()

func _on_anim_animation_finished(anim_name):
	if anim_name == "boom":
		queue_free()
	


func _on_SpellArea_body_entered(_body):
	queue_free()
