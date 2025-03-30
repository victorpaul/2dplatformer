extends Area2D

@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var game_manager: Node = %GameManager

var order_index: int = -1

func _ready() -> void:	
	if game_manager:
		order_index = game_manager.register_ordered_coin(self)
		rich_text_label.text = str(order_index)
	else:
		push_error("GameManager not found in the scene tree!")

func _on_body_entered(body) -> void:
	if game_manager.collected_ordered(self) :
		MusicAudioStreamPlayer2d.play_coin()
		queue_free()
