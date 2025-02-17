extends CanvasLayer


const API_URL = "https://apihbhai.onrender.com/leaderboard"  # Replace with your actual Flask server IP

var http_request
@onready var leaderboard_container = $Panel/VBoxContainer  # Ensure VBoxContainer exists in your scene

func _ready():
	self.visible = false
	http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

	print("Sending request to leaderboard...")
	get_leaderboard()

func get_leaderboard():
	var headers = ["Content-Type: application/json"]
	var error = http_request.request(API_URL, headers, HTTPClient.METHOD_GET)
	if error != OK:
		print("Failed to send request:", error)

func _on_request_completed(result, response_code, headers, body):
	print("HTTP Request Completed. Result:", result, "Response Code:", response_code)

	if response_code == 200:
		var json = JSON.new()
		var parse_result = json.parse(body.get_string_from_utf8())
		
		if parse_result == OK:
			var leaderboard = json.get_data()
			print("Leaderboard Data:", leaderboard)

			# Wait for VBoxContainer to be ready before calling display_leaderboard
			await get_tree().process_frame
			display_leaderboard(leaderboard)
		else:
			print("Failed to parse JSON response.")
	else:
		print("Error fetching leaderboard. HTTP Code:", response_code)

func display_leaderboard(data):
	if leaderboard_container == null:
		print("Error: leaderboard_container is missing in the scene!")
		return

	# Clear previous labels if any
	for child in leaderboard_container.get_children():
		leaderboard_container.remove_child(child)
		child.queue_free()

	# Sort by highest score and keep only top 5
	data.sort_custom(func(a, b): return a["score"] > b["score"])
	var top_5 = data.slice(0, 5)

	print("\n--- Leaderboard (Top 5) ---")
	for i in range(top_5.size()):
		var player = top_5[i]
		print("Name:", player["name"], "| Score:", player["score"])

		# Create a Label node for each player and customize its appearance
		var label = Label.new()
		label.text = "  " + str(i + 1) + "." + player["name"] + "   - Score:  " + str(player["score"])

		# Apply custom styling
		label.add_theme_font_size_override("font_size", 20)  # Larger text
		label.add_theme_color_override("font_color", Color(1, 1, 0.8))  # Light yellow text
		label.add_theme_color_override("font_color_shadow", Color(0, 0, 0))  # Shadow effect
		label.add_theme_constant_override("outline_size", 2)  # Outline thickness
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER  # Center align

		# Create a background panel for each label (for a card-like appearance)
		var bg_panel = Panel.new()
		bg_panel.add_theme_stylebox_override("panel", preload("res://scenes/command_panel.tres"))  # Preload custom style
		bg_panel.add_child(label)
		#bg_panel.size_flags_horizontal = SIZE_EXPAND_FILL
		bg_panel.custom_minimum_size = Vector2(260, 40)  # Panel size

		# Add the label inside the VBoxContainer
		leaderboard_container.add_child(bg_panel)

	print("---------------------------\n")


func _on_button_pressed() -> void:
	self.visible = false
