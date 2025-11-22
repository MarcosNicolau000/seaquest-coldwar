extends Node

var isGameRunning = false
var elapsed_time = 0.0
var scoreCount: int = 0
var gameLife = 3
var gamePhase = 0
var oxygenCount = 100
signal score_updated(new_score)

func _ready() -> void:
	start_game()

func start_game():
	gamePhase = 1
	elapsed_time = 0 
	oxygenCount = 100
	isGameRunning = true
	score_updated.emit(scoreCount)

func add_score(amount: int):
	scoreCount += amount
	score_updated.emit(scoreCount)
	
func reset_score():
	scoreCount = 0
	score_updated.emit(scoreCount)
