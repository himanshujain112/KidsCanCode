extends Node

@onready var player = $AnimationPlayer
@onready var command_panel = $CommandPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	command_panel.visible = false


func _on_execute_button_pressed() -> void:
	player.play("cmdPanelslidein")
	await player.animation_finished
