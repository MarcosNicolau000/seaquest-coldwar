extends Node
const OXYGEN_INCREASE_RATE = 8
const OXYGEN_AREA = 150


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if not GameStartRoutine.isGameRunning:
		return
	var player = $"../Player"
	if not is_instance_valid(player):
		return
	if player.global_position.y <= OXYGEN_AREA:
		if GameStartRoutine.oxygenCount < 100:
			GameStartRoutine.oxygenCount += delta*5
	else:
		GameStartRoutine.oxygenCount -= delta * 2
	if GameStartRoutine.oxygenCount <= 0:
		player.player_death()
		GameStartRoutine.isGameRunning = false
