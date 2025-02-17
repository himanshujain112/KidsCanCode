extends Node

@onready var player = $player
@onready var command_panel = $CommandPanel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	command_panel.hidden = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_execute_button_pressed() -> void:
	#
	pass