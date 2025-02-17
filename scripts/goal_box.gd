extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player entered the goal box!")
		if body.has_method("attack"):
			await get_tree().create_timer(1.0).timeout
			get_tree().change_scene_to_file("res://levels/level_" + str(GameManager.current_level_index + 1) + ".tscn")
