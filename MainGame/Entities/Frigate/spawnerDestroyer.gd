extends Node2D

@onready var frigate = preload("res://MainGame/Entities/Frigate/destroyer.tscn")
@onready var spawn_points = $SpawnPoints.get_children()
@onready var spawn_parent = get_node("../Enemies")

func _on_timer_timeout() -> void:
	var frigate = frigate.instantiate()
	var spawn = spawn_points[randi() % spawn_points.size()]
	frigate.global_position = spawn.global_position
	spawn_parent.add_child(frigate)
