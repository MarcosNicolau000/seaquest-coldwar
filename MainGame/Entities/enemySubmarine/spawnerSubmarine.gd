extends Node2D

@onready var enemySubmarine = preload("res://MainGame/Entities/enemySubmarine/enemy_submarine.tscn")
@onready var spawn_points = $SpawnPoints.get_children()
@onready var spawn_parent = get_node("../Enemies")

func _on_timer_timeout() -> void:
	var submarine = enemySubmarine.instantiate()
	var spawn = spawn_points[randi() % spawn_points.size()]
	submarine.global_position = spawn.global_position
	spawn_parent.add_child(submarine)
