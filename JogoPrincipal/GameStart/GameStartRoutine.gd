extends Node

var is_game_running = false
var elapsed_time = 0.0
var scoreCount = 0
const SCORE_RATE = 5  # Pontos por segundo
var game_life = 3
var gamePhase = 0
var oxygenCount = 1000
const OXYGEN_AREA = -160
const OXYGEN_INCREASE_RATE = 3
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()
	pass # Replace with function body.



func start_game():
	gamePhase = 1
	elapsed_time = 0 
	scoreCount = 0
	oxygenCount = 100000

func _process(delta: float) -> void:
	elapsed_time += delta
	
	
	if ($"../Player".position[1] < OXYGEN_AREA):
		if (oxygenCount < 100000):
			oxygenCount += elapsed_time*OXYGEN_INCREASE_RATE
	else:
		oxygenCount -= elapsed_time
	
	print(oxygenCount)
	scoreCount = int(elapsed_time * SCORE_RATE)
	pass
