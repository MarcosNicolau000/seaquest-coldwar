extends Area2D

const SPEED = 150.0
var direction = Vector2(1, 0)
var blood = preload("res://MainGame/Effects/blood.tscn")
var diverHitted = false

func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta

func diver_death():
	diverHitted = true
	var deathEffect = blood.instantiate() as Node2D
	deathEffect.position = position
	get_parent().add_child(deathEffect)
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemies"):
		if !diverHitted:
			diver_death()
