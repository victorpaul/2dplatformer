extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
var previous_animation: String = ""

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":	
		if body.has_method("hold_in_arms"):
			collision_shape_2d.disabled = true
			animated_sprite_2d.play("holding")
			body.hold_in_arms(self)
			
func play_spinning() -> void:
	previous_animation = animated_sprite_2d.animation
	animated_sprite_2d.play("spinning")
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.play(previous_animation)
