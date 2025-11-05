extends Node

const OXYGEN_AREA = -160
const SCORE_RATE = 5  
const OXYGEN_INCREASE_RATE = 3

var is_game_running = false
var elapsed_time = 0.0
var scoreCount = 0
var game_life = 3
var gamePhase = 0
var oxygenCount = 1000

func _ready() -> void:
	start_game()
	pass



func start_game():
	
	# VARIÁVEIS DE INÍCIO DE JOGO
	gamePhase = 1
	elapsed_time = 0 
	scoreCount = 0
	oxygenCount = 100000

func _process(delta: float) -> void:
	# CONTADOR DE TEMPO
	elapsed_time += delta	
	
	# SISTEMA DE OXIGÊNIO
	if ($"../Player".position[1] < OXYGEN_AREA):
		if (oxygenCount < 100000):
			oxygenCount += elapsed_time*OXYGEN_INCREASE_RATE
	else:
		oxygenCount -= elapsed_time

	
	# CONTADOR DE SCORE
	scoreCount = int(elapsed_time * SCORE_RATE)
	pass
