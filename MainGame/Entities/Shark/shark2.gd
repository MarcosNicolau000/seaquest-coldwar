extends CharacterBody2D

var flipCount = 0
var speed = 200
var direction = 1
@onready var shark_sprite = $Sprite2D

var blood = preload("res://MainGame/Effects/blood.tscn")
var sharkHitted = false

func _ready() -> void:
	shark_sprite.flip_h = (direction == 1)

func _physics_process(delta: float) -> void:
	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()
	if global_position.x > 1300:
		queue_free()
	
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		var area = collision.get_collider()
		if area and area.is_in_group("Diver"):
			if area.has_method("diver_death"):
				area.diver_death()
		if body is CharacterBody2D and body.is_in_group("Shark") and flipCount == 0:
			direction *= -1
			shark_sprite.flip_h = (direction == 1)
			global_position.x -= 50
			flipCount = 1
			return

func shark_death():
	sharkHitted = true
	var deathEffect = blood.instantiate() as Node2D
	deathEffect.position = position
	get_parent().add_child(deathEffect)
	queue_free()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Projectile"):
		body.queue_free()
		if !sharkHitted:
			shark_death()
			if body.is_in_group("Player"):
				GameStartRoutine.add_score(100) 
