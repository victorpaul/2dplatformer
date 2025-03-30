extends AudioStreamPlayer2D

@onready var coin: AudioStreamPlayer2D = $Coin
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var hurt: AudioStreamPlayer2D = $Hurt
@onready var explosion: AudioStreamPlayer2D = $Explosion
@onready var power_up: AudioStreamPlayer2D = $PowerUp
@onready var tap: AudioStreamPlayer2D = $Tap
@onready var voice: AudioStreamPlayer2D = $Voice


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


func _get_her_amount(amount: int) -> String:
	if amount == 1:
		return "res://assets/voice/ua_1_her.mp3"
	elif amount == 2:
		return "res://assets/voice/ua_2_she.mp3"
				
	return "res://assets/voice/ua_" + str(amount) + ".mp3"

func _get_her_coins(amount: int) -> String:
	if amount == 1:
		return "res://assets/voice/ua_coin_she.mp3"
	elif amount >= 2 and amount <= 4:
		return  "res://assets/voice/ua_coins_234.mp3"
	return "res://assets/voice/ua_coins_056789.mp3"
	
func _get_great() -> String:
	var great = [
		"res://assets/voice/ua_very_well.mp3",
		"res://assets/voice/ua_great.mp3",
		"res://assets/voice/ua_well_done.mp3",
		"res://assets/voice/ua_well_done2.mp3"
	]
	return great[randi() % great.size()]
	
func play_task_collect_coins(amount_of_coins: int) -> void:
	voice.play_voice_sequence([
		"res://assets/voice/ua_have_to_collect.mp3",
		_get_her_amount(amount_of_coins),
		_get_her_coins(amount_of_coins),
	])
	
func play_task_collect_coins_in_order(amount_of_coins: int) -> void:
	voice.play_voice_sequence([
		"res://assets/voice/ua_have_to_collect.mp3",
		_get_her_amount(amount_of_coins),
		_get_her_coins(amount_of_coins),
		"res://assets/voice/ua_in_order.mp3",
	])

func play_task_collect_coins_complete(amount_of_coins: int) -> void:
		voice.play_voice_sequence([
		_get_great(),
		"res://assets/voice/ua_was_collected.mp3",
		_get_her_amount(amount_of_coins),
		_get_her_coins(amount_of_coins),
	])
