extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":	
		if body.has_method("hold_in_arms"):
			collision_shape_2d.disabled = true
			animated_sprite_2d.play("holding")
			body.hold_in_arms(self)
			
