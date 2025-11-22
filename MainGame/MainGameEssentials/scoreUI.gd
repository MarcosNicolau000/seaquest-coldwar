extends CanvasLayer

@onready var score_label: Label = $CenterContainer/TextureRect/Label
const game_manager_path = "/root/GameStartRoutine" 
var game_manager = null

func _ready() -> void:
	game_manager = get_node_or_null(game_manager_path)
	if game_manager:
		game_manager.score_updated.connect(self._on_score_updated)
		_on_score_updated(game_manager.scoreCount)

func _on_score_updated(new_score: int):
	score_label.text = "%05d" % new_score
