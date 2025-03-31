extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:

	if Utils.has_sword_child(body):
		Utils.play_sword_hit(body)
		MusicAudioStreamPlayer2d.play_hurt()
		collision_shape_2d.queue_free()
		animated_sprite_2d.play("dead")
	else:
		animated_sprite_2d.play("attack")
		Utils.kill_player(body)
