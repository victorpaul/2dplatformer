extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Player entered killzone")
	Utils.kill_player(body)
