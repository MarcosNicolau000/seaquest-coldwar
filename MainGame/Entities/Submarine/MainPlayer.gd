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
	if GameStartRoutine.isGameRunning:
		playerMovementKeyboard(delta)
		elapsedTime += delta	
	
		# SISTEMA DE OXIGÊNIO
	
		if ($".".position[1] < OXYGEN_AREA):
			if (GameStartRoutine.oxygenCount < 100000):
				GameStartRoutine.oxygenCount += elapsedTime * OXYGEN_INCREASE_RATE
		else:
			GameStartRoutine.oxygenCount -= elapsedTime

	
		# CONTADOR DE SCORE
		GameStartRoutine.scoreCount = int(elapsedTime * SCORE_RATE)
	
		print(GameStartRoutine.oxygenCount)
	
	

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
	queue_free()

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		player_death()
		
