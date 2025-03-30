extends AudioStreamPlayer2D

# Variables to track sequence playback
var _audio_queue: Array = []
var _is_playing_sequence: bool = false
var _current_audio_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Plays a sequence of audio files one after another
# paths: Array of file paths to audio files to play in sequence
func play_voice_sequence(paths: Array) -> void:
	# Stop any currently playing sequence
	if _is_playing_sequence:
		_stop_sequence()
	
	# Validate input
	if paths.size() == 0:
		return
	
	# Store the queue and reset index
	_audio_queue = paths.duplicate()
	_current_audio_index = 0
	_is_playing_sequence = true
	
	# Start playing the first audio file
	_play_next_in_sequence()

# Stops the current sequence playback
func _stop_sequence() -> void:
	_is_playing_sequence = false
	_audio_queue.clear()
	_current_audio_index = 0
	stop()
	
	# Disconnect the finished signal if connected
	if is_connected("finished", _on_voice_finished):
		disconnect("finished", _on_voice_finished)

# Plays the next audio file in the sequence
func _play_next_in_sequence() -> void:
	if not _is_playing_sequence or _current_audio_index >= _audio_queue.size():
		_stop_sequence()
		return
	
	# Load the audio file
	var audio_path = _audio_queue[_current_audio_index]
	var audio_stream = load(audio_path)
	
	if audio_stream:
		# Set the stream and play it
		stream = audio_stream
		play()
		
		# Connect to the finished signal if not already connected
		if not is_connected("finished", _on_voice_finished):
			connect("finished", _on_voice_finished)
	else:
		print("Error loading audio file: " + audio_path)
		# Skip to the next file
		_current_audio_index += 1
		_play_next_in_sequence()

func _on_voice_finished() -> void:
	_current_audio_index += 1
	_play_next_in_sequence()
