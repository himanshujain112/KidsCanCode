extends Node
@onready var gameCharacter = $player
@onready var player = $AnimationPlayer
@onready var command_panel = $CommandPanel
var show = false
@onready var levelLabel = $CanvasLayer/level
@onready var enemySprite = $goalBox/Sprite2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.connect("executionStarted", hidethepanel)
	GameManager.current_level_index = 5
	levelLabel.text = "Level "+ str(GameManager.current_level_index)
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
	await get_tree().create_timer(1).timeout
	if player:
		get_node("player/Sprite2D").texture = preload("res://assets/images/big-pokeball.svg")
	get_tree().reload_current_scene()

func hidethepanel():
	player.play("cmdPanelslideout")
	await player.animation_finished
	GameManager.emit_signal("startExecution")
