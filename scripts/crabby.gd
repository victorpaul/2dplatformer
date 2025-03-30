extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body: Node2D) -> void:

	if _has_sword_child(body):
		MusicAudioStreamPlayer2d.play_hurt()
		collision_shape_2d.queue_free()
		animated_sprite_2d.play("dead")
	else:
		animated_sprite_2d.play("attack")
	
func _has_sword_child(node: Node2D) -> bool:
	if node.get_meta("weapon",false):
		return true
	else:
		print(node.name)
	
	for child in node.get_children():
		if _has_sword_child(child):
			return true
			
	return false
