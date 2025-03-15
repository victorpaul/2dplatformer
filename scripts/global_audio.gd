extends AudioStreamPlayer2D

@onready var coin: AudioStreamPlayer2D = $Coin

func play_coin() -> void:
	coin.play()
