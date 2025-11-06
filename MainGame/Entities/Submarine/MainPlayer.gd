extends CharacterBody2D

@export var speed = 300
var explosion = preload("res://MainGame/Effects/explosion.tscn")
var elapsedTime = 0


const OXYGEN_AREA = -160
const SCORE_RATE = 5  
const OXYGEN_INCREASE_RATE = 3

func _physics_process(delta: float) -> void:
	move_and_slide()

func _process(delta: float) -> void:
	playerMovementKeyboard(delta)
	
	

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
	
func player_death():
	var deathEffect = explosion.instantiate() as Node2D
	deathEffect.global_position = global_position
	get_parent().add_child(deathEffect)
	GameStartRoutine.gameLife -=1
	set_process(false)
	set_physics_process(false)
	visible = false
	await get_tree().create_timer(1.5).timeout
	if GameStartRoutine.gameLife == 0:
		get_tree().change_scene_to_file("res://Menu/LoserMenu/LoserMenu.tscn")
	else:
		get_tree().change_scene_to_file("res://Menu/DeathMenu/DeathMenu.tscn")
	queue_free()


func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		player_death()
		
