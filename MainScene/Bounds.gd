class_name Bounds
extends Node

@onready var upper_left: Marker2D = $UpperLeft
@onready var lower_right: Marker2D = $LowerRight

var x_max : float 
var x_min: float 
var y_max: float 
var y_min: float 

# Called when the node enters the scene tree for the first time.
func _ready():
	x_max = lower_right.position.x 
	x_min = upper_left.position.x
	y_max = lower_right.position.y 
	y_min = upper_left.position.y

func wrap_vector(v: Vector2) -> Vector2: 
	if v.x > x_max: 
		return Vector2(x_min, v.y)
	elif v.x < x_min:
		return Vector2(x_max, v.y )
	elif v.y > y_max: 
		return Vector2(v.x, y_min)
	elif v.y < y_min:
		return Vector2(v.x, y_max)
	return v
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
