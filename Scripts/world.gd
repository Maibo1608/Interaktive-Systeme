extends Node

@onready var player = $Player
@onready var hud = $HUD

#func enemy_spawne(enemy_name, spawn_time, vector_x, vector_y ):
	#if hud.game_time >= spawn_time:
		#var preload_string = "res://Scenes/Enemies/"+ enemy_name + ".tscn"
		#var enemy = load(preload_string).instantiate()
		#var enemy_spawn= Vector2(vector_x,vector_y)
		#enemy.position = player.position + enemy_spawn.rotated(deg_to_rad(randf_range(0,360)))
		#enemy.player = player
		#enemy.killed.connect(_on_enemy_killed)
		#add_child(enemy)
		

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

#func _on_enemy_timer_timeout():
	#pass
	#enemy_spawner("Enemy_Flame", 2, 400, 0)
	#enemy_spawner("Enemy_Skeleton", 20, 400, 0)$Player, $EnemyTimer, $EnemySpawner
	#enemy_spawner("Enemy_Orc_Shaman", 10, 400, 0)
	#var enemy_flame = preload("res://Scenes/Enemies/Enemy_Flame.tscn").instantiate()
	#var enemy_spawn= Vector2(400,0)
	#enemy_flame.position = player.position + enemy_spawn.rotated(deg_to_rad(randf_range(0,360)))
	#enemy_flame.player = player
	#enemy_flame.killed.connect(_on_enemy_killed)
	#add_child(enemy_flame)
	#
	#
	#if hud.game_time >= 20:
		#var enemy_skeleton = preload("res://Scenes/Enemies/Enemy_Skeleton.tscn").instantiate()
		#enemy_skeleton.position = player.position + enemy_spawn.rotated(deg_to_rad(randf_range(0,360)))
		#enemy_skeleton.player = player
		#enemy_skeleton.killed.connect(_on_enemy_killed)
		#add_child(enemy_skeleton)
	

func _on_enemy_killed(points):
	score += points
	hud.update_score(score)

func _on_player_dying():
	hud.death_screen.visible = true
	get_tree().paused = true




