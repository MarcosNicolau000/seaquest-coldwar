<<<<<<< HEAD
extends Sprite2D

@export var speed = 300

func _process(delta: float) -> void:
	playerMovementKeyboard(delta)
	playerBorderLimit()
=======
extends CharacterBody2D

@export var speed = 300
var explosion = preload("res://explosion.tscn")

func _physics_process(delta: float) -> void:
	move_and_slide()

func _process(delta: float) -> void:
	playerMovementKeyboard(delta)
	
>>>>>>> gamebase/shark

func playerMovementKeyboard(delta):
	var movement = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down"):
		movement.y += 1
	if Input.is_action_pressed("ui_up"):
		movement.y -= 1
	movement = movement.normalized()
	position += movement * speed * delta
	
<<<<<<< HEAD
func playerBorderLimit():
	var screen_size = get_viewport().size
	var sprite_half_width = self.texture.get_width() / 2
	var sprite_half_height = self.texture.get_height() / 2
	position.x = clamp(position.x, sprite_half_width, screen_size.x - sprite_half_width)
	position.y = clamp(position.y, sprite_half_height, screen_size.y - sprite_half_height)
	
=======
func player_death():
	var deathEffect = explosion.instantiate() as Node2D
	deathEffect.global_position = global_position
	get_parent().add_child(deathEffect)
	queue_free()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		player_death()
		
>>>>>>> gamebase/shark
