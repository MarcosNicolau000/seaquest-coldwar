extends Node

var ActualPhase = 1
var phaseString = "phase1"
var phaseLink = {
	"phase1": "res://MainGame/GamePhases/Phase1.tscn",
	"phase2": "res://MainGame/GamePhases/Phase2.tscn",
	"phase3": "res://MainGame/GamePhases/Phase3.tscn",
}
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if MainPlayer.diveWaveCount == 3:
		print("ENTROU!")
		ActualPhase += 1
		phaseString = "phase" + str(ActualPhase)
		if phaseLink.has(phaseString):
			get_tree().change_scene_to_file(phaseLink[phaseString])
		else: 
			print("Ganhou!")
	pass
