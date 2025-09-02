extends CharacterBody2D

#VELOCIDADE DO SUBMARINO
@export var speed = 300

# TAMANHO DA ÁREA QUE O SUBMARINO CONSEGUE ATRAVESSAR
@export var world_size: Vector2 = Vector2(1280, 720)

func _process(delta: float) -> void:
	playerMovementKeyboard(delta)
	playerBorderLimit()

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
	
	
func playerBorderLimit() -> void:
	var max_half = Vector2.ZERO

	for shape_node in get_children():
		if shape_node is CollisionShape2D:
			var shape = shape_node.shape
			var half_size = get_half_size(shape)
			var offset = shape_node.position  # deslocamento relativo ao centro do submarino

			# pega o maior alcance total considerando o deslocamento
			max_half.x = max(max_half.x, abs(offset.x) + half_size.x)
			max_half.y = max(max_half.y, abs(offset.y) + half_size.y)

	# calcula limites mínimos e máximos da área de jogo
	var min_x = max_half.x
	var min_y = max_half.y
	var max_x = world_size.x - max_half.x
	var max_y = world_size.y - max_half.y

	# aplica clamp para limitar posição
	position.x = clamp(position.x, min_x, max_x)
	position.y = clamp(position.y, min_y, max_y)
	
