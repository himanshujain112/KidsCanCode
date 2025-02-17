extends CharacterBody2D

@export var tile_size: int = 64
var facing: Vector2 = Vector2.DOWN # Default facing Down
# The player's current grid position (cell coordinates).
var grid_pos: Vector2i = Vector2i(0, 0)
func _ready():
	pass
	#add_to_group("Player")
	#position = grid_pos * tile_size

# Command execution functions return a coroutine if using await.
func move_forward():
	print("Moving forward")
	#if check_obstacle_ahead():
	#	print("Obstacle ahead")
	#	return
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
	print("attacking")

func check_obstacle_ahead() -> bool:
	var ray = RayCast2D.new()
	add_child(ray)
	ray.target_position = facing * tile_size
	ray.position = position
	ray.enabled = true
	ray.force_raycast_update()

	var colliding = ray.is_colliding()
	ray.queue_free()
	print("Colliding: ", colliding)
	return colliding