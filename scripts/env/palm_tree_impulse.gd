extends Area2D





func _on_Area2D_body_entered(body: Node):
	$anim.play("jumping")
	body.velocity.y = body.wall_jump_speed * 2


func _on_anim_animation_finished(anim_name):
	if anim_name == "jumping":
		$anim.play("idle")
