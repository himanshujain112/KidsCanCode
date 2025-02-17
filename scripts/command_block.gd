extends Panel

@export var command: String = "" # Set this per instance in the Inspector.
@onready var label: Label = $Label

func _ready() -> void:
	$Label.text = command

func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview = duplicate()
	preview.modulate.a = 0.5
	set_drag_preview(preview)
	print("dragging ", command)
	return {"command_text": command}
