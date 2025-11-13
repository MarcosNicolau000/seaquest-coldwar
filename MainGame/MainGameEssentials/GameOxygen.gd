extends Node
const OXYGEN_INCREASE_RATE = 8
const OXYGEN_AREA = 150

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if GameStartRoutine.isGameRunning:
		print(GameStartRoutine.oxygenCount)
		if $"../Player".global_position.y <= OXYGEN_AREA and GameStartRoutine.oxygenCount < 100:
			GameStartRoutine.oxygenCount += delta * OXYGEN_INCREASE_RATE
		else:
			GameStartRoutine.oxygenCount -= delta * 2
		if GameStartRoutine.oxygenCount < 0:
			$"../Player".player_death()	


	
