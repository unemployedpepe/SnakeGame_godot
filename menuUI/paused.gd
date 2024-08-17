class_name Paused
extends CanvasLayer
@onready var resume_button = $Panel/HBoxContainer/VBoxContainer/GridContainer/ResumeButton
@onready var quit_button = $Panel/HBoxContainer/VBoxContainer/GridContainer/QuitButton



func _on_resume_button_pressed():
	queue_free()

func _process(delta) -> void: 
	if Input.is_action_pressed("ui_cancel"):
		queue_free()

func _on_quit_button_pressed():
	get_tree().quit()
	
func _notification(what):
	match(what):
		NOTIFICATION_ENTER_TREE:
			get_tree().paused = true 
		NOTIFICATION_EXIT_TREE:
			get_tree().paused = false
