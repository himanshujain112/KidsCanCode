extends Node
signal obstacleAhead

var levels = [
	"res://scenes/level1.tscn",
	"res://scenes/level2.tscn",
	"res://scenes/level3.tscn"
]

var current_level_index = 0
var player_commands = []
var player
var resetCommands = false

func _ready() -> void:
	# Get the player node from the group "player"
	player = get_tree().get_first_node_in_group("player")

# Called by UI when a command is added
func add_command(command: String) -> void:
	player_commands.append(command)
	print("Added command: ", command)

# Execute the commands in sequence
func execute_commands() -> void:
	if player_commands.is_empty():
		return
	execute_next_command(0)

func execute_next_command(index: int) -> void:
	if index >= player_commands.size():
		clear_commands()
		return

	# Ensure the player instance is valid, or try re-fetching it
	if not is_instance_valid(player):
		player = get_tree().get_first_node_in_group("player")
		if not is_instance_valid(player):
			print("Player node is no longer valid. Aborting command execution.")
			clear_commands()
			return

	var command = player_commands[index]
	print("Executing command: ", command)
	match command:
		"Move Forward":
			player.move_forward()
		"Turn Left":
			player.turn_left()
		"Turn Right":
			player.turn_right()
		"Attack":
			player.attack()

	# Wait 0.5 seconds before executing the next command
	await get_tree().create_timer(0.5).timeout
	execute_next_command(index + 1)

func clear_commands() -> void:
	player_commands.clear()
