extends Control

func _ready() -> void:
	AudioManager.play_music(preload("res://assets/music/happy-kids-music-292759.mp3"))
func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credit_button_pressed() -> void:
	$leaderboard.visible = true

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level_1.tscn")
