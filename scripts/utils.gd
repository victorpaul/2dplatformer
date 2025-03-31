extends Node

@onready var timer: Timer = $Timer

func has_sword_child(node: Node2D) -> bool:
	if node.get_meta("weapon", false):
		return true
	for child in node.get_children():
		if has_sword_child(child):
			return true
	return false

func play_sword_hit(node: Node2D) -> void:
	if node.get_meta("weapon", false):
		if node.has_method("play_spinning"):
			node.play_spinning()
			return
	for child in node.get_children():
		play_sword_hit(child)

func is_player(node: Node2D) -> bool :
	return node.name == "Player"

func kill_player(node: Node2D):
	print("kill player")
	if is_player(node) :
		MusicAudioStreamPlayer2d.play_hurt()
		Engine.time_scale = 0.5
		node.get_node("CollisionShape2D").queue_free()
		timer.start()
	else:
		print("it is not a player to kill")
		

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
