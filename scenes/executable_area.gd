extends VBoxContainer

func clear_commands() -> void:
	for child in get_children():
		child.queue_free()
		
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return "command_text" in data

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if "command_text" in data:
		GameManager.add_command(data["command_text"])
	var new_panel = preload("res://scenes/command_block.tscn").instantiate()
	new_panel.command = data["command_text"]
	add_child(new_panel)
	print("dropped ", new_panel.command)

func _get_drag_data(_at_position: Vector2):
	if get_child_count() == 0:
		return
func _on_button_pressed() -> void:
	GameManager.execute_commands()
	clear_commands()