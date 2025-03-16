extends AudioStreamPlayer2D

@onready var coin: AudioStreamPlayer2D = $Coin
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var hurt: AudioStreamPlayer2D = $Hurt
@onready var explosion: AudioStreamPlayer2D = $Explosion
@onready var power_up: AudioStreamPlayer2D = $PowerUp
@onready var tap: AudioStreamPlayer2D = $Tap

func play_coin() -> void:
	coin.play()

func play_jump() -> void:
	jump.play()

func play_hurt() -> void:
	hurt.play()

func play_explosion() -> void:
	explosion.play()
	
func play_power_up() -> void:
	power_up.play()
	
func play_tap() -> void:
	tap.play()
