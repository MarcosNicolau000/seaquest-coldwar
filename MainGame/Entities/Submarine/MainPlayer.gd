extends CharacterBody2D

@export var speed = 300
@onready var player_sprite = $playerSprite
@onready var diver_label = $"../diverUI"
@onready var life_label = $"../lifeUI"
@onready var oxygen_label = $"../oxygenUI"
var explosion = preload("res://MainGame/Effects/explosion.tscn")
var elapsedTime = 0
var projectile_path = preload("res://MainGame/Entities/Submarine/projectile.tscn")

var looseDiver = false
var diver_counter: int = 0
const max_divers = 6


const fire_cooldown = 0.5
var fire_timer = 0.0

var actualPhase = 1

const OXYGEN_AREA = 150
const SCORE_RATE = 5
const OXYGEN_INCREASE_RATE = 3
var playerHitted = false

func _ready() -> void:
	Statistics.set_process(true)
	GameStartRoutine.isGameRunning = true
	update_oxygen_ui()
	update_diver_ui()
	update_life_ui()

func _physics_process(delta) -> void:
	if playerHitted:
		return
	if fire_timer > 0:
		fire_timer -= delta
	if Input.is_action_pressed("ui_accept") and fire_timer <= 0:
		fire()
	move_and_slide()
	if global_position.y <= OXYGEN_AREA:
		reset_divers()
	else:
		looseDiver = false

func reset_divers():
	if diver_counter == 6:
		GameStartRoutine.diverGoal += 6
		GameStartRoutine.add_score(1000)
		Statistics.add_rescued_diver()
		set_diver(0)
		GameStartRoutine.diveWaveCount += 1
		if GameStartRoutine.diveWaveCount == 3:
			changePhase()
	elif diver_counter < 6 and diver_counter > 0:
		if looseDiver == false:
			Statistics.add_lost_diver()
			set_diver(diver_counter - 1)
			looseDiver = true

func fire():
	fire_timer = fire_cooldown
	var projectile = projectile_path.instantiate()
	var spawn_point = $shootPos
	if is_instance_valid(spawn_point):
		projectile.global_position = spawn_point.global_position
		if is_instance_valid(player_sprite):
			projectile.should_flip = player_sprite.flip_h
		get_parent().add_child(projectile)

func _process(delta: float) -> void:
	if !playerHitted:
		playerMovementKeyboard(delta)
	
func disableHitbox():
	if has_node("Hurtbox"):
		var hurtbox = $Hurtbox
		for shape in hurtbox.get_children():
			if shape is CollisionShape2D:
				shape.disabled = true

func playerMovementKeyboard(delta):
	var movement = Vector2.ZERO
	if Input.is_action_pressed("ui_right") or Input.is_action_pressed("right"):
		movement.x += 1
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("left"):
		movement.x -= 1
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("baixo"):
		movement.y += 1
	if Input.is_action_pressed("ui_up") or Input.is_action_pressed("cima"):
		movement.y -= 1
	movement = movement.normalized()
	if is_instance_valid(player_sprite):
		if movement.x > 0:
			player_sprite.flip_h = false
		elif movement.x < 0:
			player_sprite.flip_h = true
	position += movement * speed * delta

func player_death():
	if playerHitted:
		return
	playerHitted = true
	disableHitbox()
	var deathEffect = explosion.instantiate() as Node2D
	deathEffect.global_position = global_position
	get_parent().add_child(deathEffect)
	await deathEffect
	diver_counter = 0
	update_diver_ui()
	update_oxygen_ui()
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)	
	tween.tween_property(self, "modulate:a", 0.0, 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)	
	await tween.finished
	await get_tree().create_timer(0.5).timeout
	GameStartRoutine.gameLife -=1
	Statistics.add_death()
	update_life_ui()
	visible = false
	await get_tree().create_timer(1.5).timeout
	if GameStartRoutine.gameLife == 0:
		get_tree().change_scene_to_file("res://Menu/LoserMenu/LoserMenu.tscn")
	else:
		get_tree().reload_current_scene()
	GameStartRoutine.oxygenCount = 100
	queue_free()

func _on_hurtbox_body_entered(body: Node2D) -> void:	
	if body.is_in_group("Enemies"):
		if !playerHitted:
			player_death()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Diver"):
		if diver_counter < max_divers:
			set_diver(diver_counter + 1)
			area.queue_free()
		else:
			pass

func changePhase():
	GameStartRoutine.gamePhase = 2
	get_tree().change_scene_to_file("res://MainGame/GamePhases/NextLevel2.tscn")

func set_diver(new_diver_count: int) -> void:
	diver_counter = new_diver_count
	update_diver_ui()

func update_diver_ui():
	if not is_instance_valid(diver_label):
		return
	var template = "[img=100]res://MainGame/Entities/Diver/Mergulhador.png[/img][color=black][font_size=36]{contagem}[/font_size][/color] [color=black][font_size=32]X[/font_size][/color]"
	diver_label.text = template.format({
		"contagem": str(diver_counter)
	})
	$"../diversGoal".text = "Meta: " + str(GameStartRoutine.diverGoal) + "/18"
	
func update_life_ui():
	if not is_instance_valid(life_label):
		return
	var template = "[img=100]res://MainGame/MainGameEssentials/Iron_heart.png[/img][color=black][font_size=36]{contagem}[/font_size][/color] [color=black][font_size=32]X[/font_size][/color]"
	life_label.text = template.format({
		"contagem": str(GameStartRoutine.gameLife)
	})

func update_oxygen_ui():
	if not is_instance_valid(oxygen_label):
		return
	var template = "[img=100]res://MainGame/MainGameEssentials/Oxygen_tank.png[/img][color=black][font_size=36]{contagem}[/font_size][/color][color=black][font_size=36]/100[/font_size][/color]"
	var oxygen_int = int(GameStartRoutine.oxygenCount)
	oxygen_label.text = template.format({
		"contagem": str(oxygen_int)
	})
