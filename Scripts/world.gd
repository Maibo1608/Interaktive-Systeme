extends Node

@onready var player = $Player

var score
var highscore = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_game():
	score = 0
	$StartTimer.start()
	$Menu.update_score(score)
	$Menu.update_highscore(score)
	$Menu.show_message("Get Ready") # Replace with function body.

func _on_enemy_timer_timeout():
	var enemy = preload("res://Scenes/Enemy.tscn").instantiate()
	var enemy_spawn= Vector2(400,0)
	enemy.position = player.position + enemy_spawn.rotated(deg_to_rad(randf_range(0,360)))
	enemy.player = player
	enemy.killed.connect(_on_enemy_killed)
	add_child(enemy)

func _on_enemy_killed(points):
	highscore += points
	$Menu.update_highscore(highscore)


func _on_score_timer_timeout():
	score += 1
	$Menu.update_score(score)


func _on_start_timer_timeout():
	$ScoreTimer.start()



