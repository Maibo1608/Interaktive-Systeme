extends CanvasLayer

signal start_game


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# wait until the message Timer has counted down
	await $MessageTimer.timeout
	
	$Message.text = "Survive as long as possible!"
	$Message.show()
	
	#make a one shot timer and wait for it to finish
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
func update_highscore(highscore):
	$Highscore.text = str(highscore)
	

func _on_start_pressed():
	$Start.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()


