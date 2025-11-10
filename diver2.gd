extends Area2D

var flipCount = 0
const SPEED = 150.0
var direction = Vector2(-1, 0)
@onready var diver_sprite = $AnimatedSprite2D

func _ready() -> void:
	diver_sprite.flip_h = (direction.x == -1)

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta
