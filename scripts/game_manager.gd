extends Node

var levels = [
	"res://scenes/level1.tscn",
	"res://scenes/level2.tscn",
	"res://scenes/level3.tscn"
]

var current_level_index = 0

var player_commands = []
var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
#called by ui when a command is added
func add_command(command: String) -> void:
	player_commands.append(command)
	print("Added command: ", command)

#execute the command in sequence
func execute_commands() -> void:
	if player_commands.is_empty():
		return
	execute_next_command(0)

func execute_next_command(index):
	if index >= player_commands.size():
		clear_commands()
		return
	
	var command = player_commands[index]
	print("Executing command ", command)

	match command:
		"Move Forward":
			player.move_forward()
		"Turn Left":
			player.turn_left()
		"Turn Right":
			player.turn_right()
		"Attack":
			player.attack()
		
	await get_tree().create_timer(0.5).timeout
	execute_next_command(index + 1)

func clear_commands() -> void:
	player_commands.clear()