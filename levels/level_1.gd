extends Node
@onready var gameCharacter = $player
@onready var player = $AnimationPlayer
@onready var command_panel = $CommandPanel
var show = false
@onready var enemySprite = $goalBox/Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.current_level_index = 1
	command_panel.visible = false
	GameManager.connect("obstacleAhead", Callable(self, "_on_obstacle_ahead"))
	if is_instance_valid(enemySprite):
		enemySprite.texture = preload("res://assets/images/pokemons/pikachu.svg")

func _on_execute_button_pressed() -> void:
	if show == false:
		$CanvasLayer/ExecuteButton.text = "Hide"
		show = true
		player.play("cmdPanelslidein")
		await player.animation_finished
		return
	elif show == true:
		$CanvasLayer/ExecuteButton.text = "Show"
		show = false
		player.play("cmdPanelslideout")
		await player.animation_finished
		return

func _on_reset_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_obstacle_ahead() -> void:
	
	if gameCharacter:
		get_node("player/Sprite2D").texture = preload("res://assets/images/big-pokeball.svg")
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()