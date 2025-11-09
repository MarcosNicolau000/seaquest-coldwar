extends CharacterBody2D

var flipCount = 0
var speed = 8000
var direction = 1
@onready var shark_sprite = $Sprite2D

var sharkHitted = false

func _ready() -> void:
	shark_sprite.flip_h = (direction == 1)

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed * delta
	move_and_slide()
	if global_position.x > 1300:
		queue_free()
	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		
		if body is CharacterBody2D and body.is_in_group("Enemies") and flipCount == 0:
			direction *= -1
			shark_sprite.flip_h = (direction == 1)
			global_position.x -= 50
			flipCount = 1
			return


	
