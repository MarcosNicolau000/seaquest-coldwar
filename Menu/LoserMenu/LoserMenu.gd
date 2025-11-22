extends Control

@onready var menu_vitoria: Control = $"TelaDerrota"
@onready var menu_estatisticas: Control = $"TelaEstatisticas"

func _ready() -> void:
	Statistics.set_process(false)
	Statistics.stats_updated.connect(update_label)
	update_label()
	menu_vitoria.visible = true
	menu_estatisticas.visible = false
	$TelaDerrota/RichTextLabel.text = str(GameStartRoutine.scoreCount)
	GameStartRoutine.isGameRunning = false

func update_label():
	$TelaEstatisticas/Stats.text = "Mortes: %d\nTempo de Jogo: %s\nMergulhadores Resgatados: %d\nTubarões Mortos: %d\nSubmarinos Inimigos Destruídos: %d" % [
	Statistics.death_count,
	Statistics.format_time(),              
	Statistics.rescued_divers_count,
	Statistics.shark_count,
	Statistics.enemy_submarine_count
]

func _on_voltar_menu_pressed() -> void:
	Statistics.reset()
	GameStartRoutine.reset_score()
	GameStartRoutine.gameLife = 3
	GameStartRoutine.gamePhase = 0
	GameStartRoutine.isGameRunning = false
	get_tree().change_scene_to_file("res://Menu/MainMenu/MainMenu.tscn")

func _on_estatisticas_pressed() -> void:
	menu_vitoria.visible = false
	menu_estatisticas.visible = true

func _on_voltar_pressed() -> void:
	menu_vitoria.visible = true
	menu_estatisticas.visible = false
