extends CharacterBody2D

@onready var tilemap = get_parent().get_node("TileMapLayer")
@export var tile_size: int = 64
var facing: Vector2 = Vector2.DOWN # Default facing Down
# The player's current grid position (cell coordinates).
var grid_pos: Vector2i = Vector2i(0, 0)

func _ready():
	pass
	# add_to_group("Player")
	# position = grid_pos * tile_size

# Command execution functions return a coroutine if using await.
func move_forward():
	print("Moving forward")
	if check_obstacle_ahead():
		print("Obstacle ahead!")
		GameManager.emit_signal("obstacleAhead")
		return
	position += facing * tile_size

func turn_left() -> void:
	facing = facing.rotated(deg_to_rad(-90))
	rotation -= deg_to_rad(90)
	print("Turning left")

func turn_right() -> void:
	facing = facing.rotated(deg_to_rad(90))
	rotation += deg_to_rad(90)
	print("Turning right")

func attack() -> void:
	print("Attacking")

func check_obstacle_ahead() -> bool:
	var target_pos = position + facing * tile_size # Calculate the position ahead
	var tile_pos = tilemap.local_to_map(target_pos) # Convert world position to tile coordinates
	
	# Get the tile data at the tile position (only one argument is needed)
	var tile_data = tilemap.get_cell_tile_data(tile_pos)
	
	# Check if the tile has the custom data "obstacle" set to true
	if tile_data and tile_data.get_custom_data("obstacle"):
		return true
	
	return false
