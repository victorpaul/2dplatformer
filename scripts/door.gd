extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Public variable to track door state
@export var is_open: bool = false

# Door configuration
@export_category("Door Configuration")
@export_file("*.tscn") var target_level: String = ""
@export var transition_delay: float = 0.5

func _ready():
	# Initialize the door to closed state
	if is_open:
		# Show first frame of close animation if door is open
		animated_sprite_2d.animation = "close"
		animated_sprite_2d.frame = 0
	else:
		# Show first frame of open animation if door is closed
		animated_sprite_2d.animation = "open"
		animated_sprite_2d.frame = 0

# Public method to open the door
func open():
	if not is_open:
		MusicAudioStreamPlayer2d.play_power_up()
		animated_sprite_2d.play("open")
		is_open = true
		# Connect to animation_finished signal if not already connected
		if not animated_sprite_2d.is_connected("animation_finished", _on_animation_finished):
			animated_sprite_2d.connect("animation_finished", _on_animation_finished)

# Public method to close the door
func close():
	if is_open:
		animated_sprite_2d.play("close")
		is_open = false
		# Connect to animation_finished signal if not already connected
		if not animated_sprite_2d.is_connected("animation_finished", _on_animation_finished):
			animated_sprite_2d.connect("animation_finished", _on_animation_finished)

# Handle animation completion
func _on_animation_finished():
	# Stop at the last frame when animation completes
	animated_sprite_2d.stop()
	
	# Set the correct frame based on door state
	if is_open:
		# Show first frame of close animation when door is open
		animated_sprite_2d.animation = "close"
		animated_sprite_2d.frame = 0
	else:
		# Show first frame of open animation when door is closed
		animated_sprite_2d.animation = "open"
		animated_sprite_2d.frame = 0

func _on_body_entered(body: Node2D) -> void:
	if is_open:
		#print("Someone entered open door")
		#MusicAudioStreamPlayer2d.play_coin()
		
		if target_level != "":
			var err = get_tree().change_scene_to_file(target_level)
			if err != OK:
				print("Error changing scene: " + str(err))
