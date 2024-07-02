extends CanvasLayer

@onready var time = $stats/HBoxContainer/VBoxContainer/time_value
@onready var score = $stats/HBoxContainer/VBoxContainer/score_value
@onready var highscore = $stats/HBoxContainer/VBoxContainer/highscore_value
@onready var death_screen = $death_screen
@onready var xpbar = $xpbar
@onready var lvlup_screen = $lvlup_screen
@onready var xp_label = $xpbar/xp_label
@onready var level_label = $xpbar/level_label


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
	
func on_save_score(value):
	if value > SaveLoad.highest_record:
		SaveLoad.highest_record = value
		highscore.text = str(value)
	SaveLoad.save_score()
	
func show_highscore():
	highscore.text = str(SaveLoad.highest_record)

func update_xpbar(xp):
	xpbar.value += xp
	xp_label.text = "%02d / %02d" % [xpbar.value, xpbar.max_value]

func lvlup():
	xpbar.max_value = player.current_lvl * 75
	xpbar.value = 0
	xp_label.text = "%d / %d" % [xpbar.value, xpbar.max_value]
	lvlup_screen.visible = true
	level_label.text = "LEVEL " + str(player.current_lvl)
	
	


func _on_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_attack_1_pressed():
	player.attack1_lvl+=1
	get_tree().paused = false
	lvlup_screen.visible = false
	$lvlup_screen/VBoxContainer/attack1.text = "SWORD - LVL %d" % [player.attack1_lvl]


func _on_attack_2_pressed():
	player.attack2_lvl+=1
	player.attack2_reload.wait_time = 2 - (player.attack2_lvl/5)
	get_tree().paused = false
	lvlup_screen.visible = false
	$lvlup_screen/VBoxContainer/attack2.text = "FIRE STAFF - LVL %d" % [player.attack2_lvl]


func _on_heart_pressed():
	player.heart_lvl+=1
	player.max_health += 20
	player.healthbar.max_value += 20
	player.healthbar.value += 20
	player.health += 20
	get_tree().paused = false
	lvlup_screen.visible = false
	$lvlup_screen/VBoxContainer/heart.text = "HEALTH GEM - LVL %d" % [player.heart_lvl]


func _on_boots_pressed():
	player.boots_lvl+=1
	player.speed += 20
	get_tree().paused = false
	lvlup_screen.visible = false
	$lvlup_screen/VBoxContainer/boots.text = "BOOTS - LVL %d" % [player.boots_lvl]
