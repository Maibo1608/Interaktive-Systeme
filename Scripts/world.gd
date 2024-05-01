extends Node

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_timer_timeout():
	var enemy = preload("res://Scenes/Enemy.tscn").instantiate()
	var enemy_spawn= Vector2(400,0)
	enemy.position = player.position + enemy_spawn.rotated(deg_to_rad(randf_range(0,360)))
	enemy.player = player
	add_child(enemy)
