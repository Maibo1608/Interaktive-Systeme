extends Node

@onready var player = $Player
@onready var hud = $HUD

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player.dying.connect(_on_player_dying)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	score = 0
	hud.update_score(score)

func _on_enemy_timer_timeout():
	var enemy = preload("res://Scenes/Enemy.tscn").instantiate()
	var enemy_spawn= Vector2(400,0)
	enemy.position = player.position + enemy_spawn.rotated(deg_to_rad(randf_range(0,360)))
	enemy.player = player
	enemy.killed.connect(_on_enemy_killed)
	add_child(enemy)

func _on_enemy_killed(points):
	score += points
	hud.update_score(score)

func _on_player_dying():
	hud.death_screen.visible = true
	get_tree().paused = true




