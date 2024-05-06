extends CanvasLayer

@onready var time = $HBoxContainer/VBoxContainer/time_value
@onready var score = $HBoxContainer/VBoxContainer/score_value
@onready var death_screen = $death_screen


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
