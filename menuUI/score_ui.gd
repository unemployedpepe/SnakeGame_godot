class_name ScoreUI
extends CanvasLayer

@onready var score = %Score
@onready var high_score = %HighScore

# Called when the node enters the scene tree for the first time.
func _ready():
	high_score.text = "HighScore: " + str(Globals.save_data.high_score)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_score(n:int):
	score.text = "Score: " + str(n)
