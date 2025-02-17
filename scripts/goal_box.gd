extends Area2D

@onready var audio = $AudioStreamPlayer

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Player entered the goal box!")
		if body.has_method("Catch"):
			AudioManager.play_temporary_music(preload("res://assets/music/Pokemon Sword and Shield - Capture Sound Effect [Free Ringtone Download].mp3"))
			await AudioManager.music_player.finished
			#await get_tree().create_timer(1.0).timeout
			if GameManager.current_level_index < 5:
				get_tree().change_scene_to_file("res://levels/level_" + str(GameManager.current_level_index + 1) + ".tscn")
			else:
				get_tree().change_scene_to_file("res://mainMenu.tscn")
