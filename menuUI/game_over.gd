class_name GameOver
extends CanvasLayer

@onready var score_label = %ScoreLabel
@onready var high_score_label = %HighScoreLabel
@onready var restart_button = %RestartButton
@onready var quit_button = %QuitButton

func set_score(n:int): 
	score_label.text = "Final Score: " + str(n)
	if n > Globals.save_data.high_score: 
		high_score_label.visible = true 
		Globals.save_data.high_score = n
		Globals.save_data.save()
	else:
		high_score_label.visible = false 

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _notification(what):
	match(what):
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true 
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false 
		
