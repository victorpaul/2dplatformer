extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@onready var mid: TileMapLayer = %TileMapLayer

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -200.0

var is_on_ladder = false
var jump_on_ladder = false
var prev_state_is_on_floor = false

func _process(delta: float) -> void:
	var map_position = mid.local_to_map(mid.to_local(global_position))
	var cell_data = mid.get_cell_tile_data(map_position)
	is_on_ladder = cell_data && cell_data.get_custom_data("ladder")
	
	var jump_pressed = Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("move_up")
	if jump_pressed && is_on_floor() && !is_on_ladder: 
		MusicAudioStreamPlayer2d.play_jump()
		
	if prev_state_is_on_floor != is_on_floor() :
		prev_state_is_on_floor = is_on_floor()
		if prev_state_is_on_floor :
			MusicAudioStreamPlayer2d.play_tap()

func _physics_process(delta: float) -> void:	
	# jump fall logic
	var jump_pressed = Input.is_action_just_pressed("jump") || Input.is_action_just_pressed("move_up")
	if !is_on_floor() && !is_on_ladder :
		velocity += get_gravity() * delta
	if jump_pressed && is_on_floor() && !is_on_ladder: 
		velocity.y = JUMP_VELOCITY
		MusicAudioStreamPlayer2d.play_jump()
		
	# ladder climb
	if is_on_ladder :
		if Input.is_action_just_pressed("jump") :
			jump_on_ladder = true
		elif Input.is_action_just_released("jump") :
			jump_on_ladder = false
		if jump_on_ladder :
			velocity.y = -SPEED
		else :
			var directionUpDown := Input.get_axis("move_up", "move_down")
			velocity.y = directionUpDown * SPEED
	else:
		jump_on_ladder = false
	
	# x movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# animation
	if !is_on_floor() && !is_on_ladder:
		animated_sprite_2d.play("jump")
	else:
		animated_sprite_2d.play("idle" if direction == 0 else "run")
		
	move_and_slide()
