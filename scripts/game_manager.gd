extends Node

@export_category("Configurable")
@export var door: Node2D
@export_category("OpenDoorWhen")

@export var collectAllCoins: bool

var points = 0
var total_coins = 0

func add_point() -> void:
	points += 1
	print("Collected coin: " + str(points) + "/" + str(total_coins))
	_check_task_state()
	
func _check_task_state() -> void:
	if collectAllCoins and points >= total_coins :
		print("All coins collected! Opening door...")
		if door and door.has_method("open"):
			door.open()
		await get_tree().create_timer(1).timeout
		MusicAudioStreamPlayer2d.play_task_collect_coins_complete(points)

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	if collectAllCoins :
		_check_task_state()
		MusicAudioStreamPlayer2d.play_task_collect_coins(total_coins)
		
	
		#for 	i in 10 :
			#MusicAudioStreamPlayer2d.play_task_collect_coins(i)
			#await get_tree().create_timer(3).timeout
