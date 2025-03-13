extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60
@onready var right_ray_cast_2d: RayCast2D = $RightRayCast2D
@onready var left_ray_cast_2d_2: RayCast2D = $LeftRayCast2D2

var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += SPEED * direction * delta
	
	if right_ray_cast_2d.is_colliding() :
		direction = -1
		animated_sprite_2d.flip_h = true
	if left_ray_cast_2d_2.is_colliding() :
		direction = 1
		animated_sprite_2d.flip_h = false
	
