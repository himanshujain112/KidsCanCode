extends Node

var music_player: AudioStreamPlayer
var main_music: AudioStream
var is_main_music_playing: bool = false

func _ready():
	# Create and configure the AudioStreamPlayer
	music_player = AudioStreamPlayer.new()
	music_player.bus = "Music"  # Set the audio bus (optional)
	add_child(music_player)
	
	# Connect finished signal for manual looping
	music_player.connect("finished", Callable(self, "_on_music_finished"))

# Function to start the main music
func play_music(music: AudioStream, loop: bool = true):
	if not music:
		return  # Avoid errors if no music is provided

	main_music = music
	is_main_music_playing = true

	music_player.stream = main_music
	music_player.play()
	
	if loop:
		music_player.connect("finished", Callable(self, "_on_music_finished"), CONNECT_DEFERRED)
	else:
		music_player.disconnect("finished", Callable(self, "_on_music_finished"))

# Function to play an interrupting sound and resume the main music after
func play_temporary_music(temp_music: AudioStream):
	if not temp_music:
		return

	if music_player.playing:
		music_player.stop()  # Pause main music
		is_main_music_playing = false

	# Play the temporary music
	music_player.stream = temp_music
	music_player.play()

	# Wait for it to finish, then resume the main music
	music_player.connect("finished", Callable(self, "_resume_main_music"), CONNECT_DEFERRED)

# Function to resume the main music after interruption
func _resume_main_music():
	music_player.disconnect("finished", Callable(self, "_resume_main_music"))

	if main_music and not is_main_music_playing:
		play_music(main_music)  # Resume main music

# Function to loop the main music
func _on_music_finished():
	if is_main_music_playing:
		music_player.play()  # Restart main music
