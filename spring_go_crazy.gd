extends Block

export var jump_multiplier:float = 2.5
# 1.63 ^^

func _on_body_entered(body):
	if body.is_in_group("Player"):
		if body.has_method("force_jump"):
			body.force_jump(jump_multiplier)
