extends CanvasLayer

@onready var highscore_label = %HighscoreLabel
@onready var start_button = %StartButton
@onready var quit_button = %QuitButton

const gameplay_scene : PackedScene = preload("res://MainScene/main_scene.tscn")

func _ready():
	var high_score:int = Globals.save_data.high_score
	highscore_label.text = "HighScore " + str(high_score)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("enter_start"):
		_on_start_button_pressed()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(gameplay_scene)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
