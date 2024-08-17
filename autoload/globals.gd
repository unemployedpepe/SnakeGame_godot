extends Node

const GRID_SIZE: int = 32 

var save_data : SaveData

func _ready():
	save_data = SaveData.load_or_create()
