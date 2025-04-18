extends Node

@export_category("Configurable")
@export var door: Node2D
@export_category("OpenDoorWhen")

var points = 0
var total_coins = 0

var enemies_defeated = 0
var total_enemies = 0

var ordered_coin_index = 0
var ordered_coins = []

func register_coin(coin) -> void:
	total_coins +=1

func register_enemy(enemy) -> void:
	total_enemies +=1
	
func register_ordered_coin(coin) -> int:
	total_coins +=1
	ordered_coins.append(coin)
	return ordered_coins.size()
	
func collected_ordered(coin) -> bool:
	if coin == ordered_coins[ordered_coin_index] :
		ordered_coin_index+=1
		add_point()
		return true
	return false
	

func add_point() -> void:
	points += 1
	print("Collected coin: " + str(points) + "/" + str(total_coins))
	_check_task_state()
	
func add_defeated_enemy(enemy) -> void:
	enemies_defeated += 1
	_check_task_state()

func _check_task_state() -> void:
	if total_coins > 0 && points >= total_coins :
		print("All coins collected! Opening door...")
		open_door()
		await get_tree().create_timer(1).timeout
		MusicAudioStreamPlayer2d.play_task_collect_coins_complete(points)
		
	if total_enemies > 0 && enemies_defeated >= total_enemies :
		print("All enemies defeated! Opening door...")
		open_door()
		await get_tree().create_timer(1).timeout
		MusicAudioStreamPlayer2d.play_defeated_enemies(enemies_defeated)

func open_door() -> void:
	if door and door.has_method("open"):
			door.open()

func _ready() -> void:
	await get_tree().create_timer(1).timeout
	
	_check_task_state()
	
	if total_coins > 0 :
		if ordered_coins.is_empty() :
			MusicAudioStreamPlayer2d.play_task_collect_coins(total_coins)
		else :
			MusicAudioStreamPlayer2d.play_task_collect_coins_in_order(total_coins)
		
	if total_enemies > 0 :
		MusicAudioStreamPlayer2d.play_task_defeat_enemies(total_enemies)
		
	#for 	i in 10 :
		#MusicAudioStreamPlayer2d.play_task_collect_coins(i)
		#await get_tree().create_timer(3).timeout
