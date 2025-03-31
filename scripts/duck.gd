extends Area2D

@export var SPEED = 50.0
@export var MIN_DISTANCE = 20.0
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var player : Node2D = null
var velocity = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if player:
		var direction = player.position - position
		var distance = direction.length()
		
		if distance > MIN_DISTANCE:
			direction = direction.normalized()
			velocity = direction * SPEED
			position += velocity * delta
			
			position.y = lerp(position.y, player.position.y, delta * 5.0)
			animated_sprite_2d.flip_h = direction.x < 0
			animated_sprite_2d.play("run")
		else:
			velocity = Vector2.ZERO
			position.y = lerp(position.y, player.position.y, delta * 5.0)
			animated_sprite_2d.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if Utils.is_player(body) :
		collision_shape_2d.queue_free()
		player = body.get_tail(self)
