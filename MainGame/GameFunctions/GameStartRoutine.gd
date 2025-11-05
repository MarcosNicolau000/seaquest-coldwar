extends Node

var isGameRunning = false
var elapsed_time = 0.0
var scoreCount = 0
var gameLife = 3
var gamePhase = 0
var oxygenCount = 100000

func _ready() -> void:
	start_game()
	pass



func start_game():	
	# VARIÁVEIS DE INÍCIO DE JOGO
	gamePhase = 1
	elapsed_time = 0 
	scoreCount = 0
	oxygenCount = 100000
	isGameRunning = true
	

func _process(delta: float) -> void:
	pass
