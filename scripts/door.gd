extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

# Public variable to track door state
@export var is_open: bool = false

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
