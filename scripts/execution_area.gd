extends VBoxContainer

# This array stores the commands in the order they are dropped.
var commands: Array = []

# Called when something is dragged over this container
func can_drop_data(position: Vector2, data: Variant) -> bool:
    return data.has("command") # Accept only if the data includes a "command"

# Called when data is dropped onto the container
func drop_data(position: Vector2, data: Variant) -> void:
    # Create a Label to visually represent the dropped command
    var label = Label.new()
    label.text = data["command"]
    add_child(label)
    # Store the command for later execution
    commands.append(data["command"])
