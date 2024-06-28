extends Node

@onready var player = $Player
@onready var hud = $HUD
@onready var enemy_spawner = $EnemySpawner
@onready var menu = get_tree().get_first_node_in_group("Menu")
@onready var music = $Music
@onready var death_sound = $DeathSound

var score = 0




# Called when the node enters the scene tree for the first time.
func _ready():
	music.play()
	hud.show_highscore()
	player.dying.connect(_on_player_dying)
	enemy_spawner.killed.connect(_on_enemy_killed)
	player.lvlup.connect(_on_player_lvlup)
	hud.player = player
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.S
func _process(delta):
	pass
		

func new_game():
	score = 0
	hud.update_score(score)

func _on_enemy_killed(points, xp):
	score += points
	hud.update_score(score)
	hud.update_xpbar(xp)
	player.current_xp += xp

func _on_player_dying():
	music.stop()
	hud.on_save_score(score)
	death_sound.play()
	hud.death_screen.visible = true
	get_tree().paused = true
	
	

func _on_player_lvlup():
	hud.lvlup()
	music.playing
	get_tree().paused = true


