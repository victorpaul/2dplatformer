extends Area2D

@onready var game_manager: Node = %GameManager

func _ready() -> void:
	game_manager.register_coin(self)


func _on_body_entered(body: Node2D) -> void:
	game_manager.add_point()
	MusicAudioStreamPlayer2d.play_coin()
	queue_free()
