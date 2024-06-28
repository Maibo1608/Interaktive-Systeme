extends CanvasLayer

@onready var time = $HBoxContainer/VBoxContainer/time_value
@onready var score = $HBoxContainer/VBoxContainer/score_value
@onready var highscore = $HBoxContainer/VBoxContainer/highscore_value
@onready var death_screen = $death_screen
@onready var xpbar = $xpbar
@onready var lvlup_screen = $lvlup_screen


@export var player:= CharacterBody2D

var game_time = 0
var seconds = 0
var minutes = 0

func _process(delta):
	if(!get_tree().paused):
			game_time += delta
	seconds = fmod(game_time, 60)
	minutes = fmod(game_time, 60*60) / 60
	time.text = "%02d : %02d" % [minutes, seconds]

func update_score(value):
	score.text = str(value)
	print("update_score")
	print(SaveLoad.highest_record)
	
func on_save_score(value):
	if value > SaveLoad.highest_record:
		SaveLoad.highest_record = value
		highscore.text = str(value)
	SaveLoad.save_score()
	print("update_highscore")
	
func show_highscore():
	highscore.text = str(SaveLoad.highest_record)
	print("show_highscore")

func update_xpbar(xp):
	xpbar.value += xp
	

func lvlup():
	xpbar.max_value = player.current_lvl * 100
	xpbar.value = 0
	
	lvlup_screen.visible = true
	
	


func _on_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_attack_1_pressed():
	player.attack1_lvl+=1
	get_tree().paused = false
	lvlup_screen.visible = false


func _on_attack_2_pressed():
	player.attack2_lvl+=1
	get_tree().paused = false
	lvlup_screen.visible = false


func _on_heart_pressed():
	player.heart_lvl+=1
	player.healthbar.max_value +=20
	player.health += 20
	player.max_health += 20
	get_tree().paused = false
	lvlup_screen.visible = false


func _on_boots_pressed():
	player.boots_lvl+=1
	player.speed += 20
	get_tree().paused = false
	lvlup_screen.visible = false
