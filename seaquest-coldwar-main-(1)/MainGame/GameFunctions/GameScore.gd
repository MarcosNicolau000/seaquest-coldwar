extends Node

const SCORE_RATE = 5  
var elapsedTime = 0;

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if GameStartRoutine.isGameRunning:
		elapsedTime += delta
		GameStartRoutine.scoreCount = int(elapsedTime * SCORE_RATE)
		
	pass
